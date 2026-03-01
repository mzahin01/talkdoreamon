import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Unified audio service that handles both decibel monitoring and voice capture.
/// This resolves the dual-recorder conflict by using a single FlutterSoundRecorder
/// that switches between monitoring mode and capture mode.
class DecibelService extends GetxService {
  static DecibelService get to => Get.find();

  // Decibel monitoring
  RxDouble decibelLevel = 0.0.obs;
  RxDouble weightedDecibelLevel = 0.0.obs;
  List<double> decibelLevels = [];

  // Single recorder for everything
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;
  StreamSubscription? _recorderSubscription;

  // Recording state
  RxBool isCapturing = false.obs;
  String? _captureFilePath;
  String? _monitorFilePath;

  // Callback for decibel updates (used by controller)
  void Function(double decibel)? onDecibelUpdate;

  @override
  void onInit() {
    super.onInit();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    // Request microphone permission (not needed on web)
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }

    await _recorder.openRecorder();
    _isRecorderInitialized = true;

    await _recorder.setSubscriptionDuration(
      const Duration(milliseconds: 100),
    );

    // Get proper file paths - web uses simple names, native uses temp directory
    if (kIsWeb) {
      _monitorFilePath = 'decibel_monitor.webm';
      _captureFilePath = 'voice_capture.webm';
    } else {
      final tempDir = await getTemporaryDirectory();
      _monitorFilePath = '${tempDir.path}/decibel_monitor.aac';
      _captureFilePath = '${tempDir.path}/voice_capture.aac';
    }

    // Start monitoring mode
    await _startMonitoring();
  }

  /// Get the appropriate codec for the current platform
  Codec get _codec => kIsWeb ? Codec.opusWebM : Codec.aacMP4;

  void _setupDecibelListener() {
    _recorderSubscription?.cancel();
    _recorderSubscription =
        _recorder.onProgress!.listen((RecordingDisposition event) {
      double decibels = event.decibels ?? 0.0;
      decibelLevel.value = decibels;
      decibelLevels.add(decibels);

      // Keep only the last 1 second of decibel levels (10 samples at 100ms each)
      if (decibelLevels.length > 10) {
        decibelLevels.removeAt(0);
      }

      // Give more weight to recent values for smoother response
      double weightedSum = 0;
      double weightTotal = 0;
      for (int i = 0; i < decibelLevels.length; i++) {
        double weight = (i + 1.0);
        weightedSum += decibelLevels[i] * weight;
        weightTotal += weight;
      }
      weightedDecibelLevel.value = weightedSum / weightTotal;

      // Notify listener
      onDecibelUpdate?.call(weightedDecibelLevel.value);
    });
  }

  /// Start monitoring mode - records to a throwaway file just to get decibel levels
  Future<void> _startMonitoring() async {
    if (!_isRecorderInitialized) return;

    _setupDecibelListener();

    await _recorder.startRecorder(
      toFile: _monitorFilePath,
      codec: _codec,
      sampleRate: 44100,
      numChannels: 1,
    );

    debugPrint('[DecibelService] Started monitoring mode');
  }

  /// Start capturing user's voice for playback
  /// This stops monitoring and starts recording to the capture file
  Future<void> startCapture() async {
    if (!_isRecorderInitialized || isCapturing.value) return;

    debugPrint('[DecibelService] Starting voice capture...');

    // Stop current monitoring
    await _recorder.stopRecorder();

    // Clear decibel history
    decibelLevels.clear();

    // Setup listener again and start capturing
    _setupDecibelListener();

    await _recorder.startRecorder(
      toFile: _captureFilePath,
      codec: _codec,
      sampleRate: 44100,
      numChannels: 1,
    );

    isCapturing.value = true;
    debugPrint('[DecibelService] Voice capture started');
  }

  /// Stop capturing and return the file path of the captured audio
  Future<String?> stopCapture() async {
    if (!_isRecorderInitialized || !isCapturing.value) return null;

    debugPrint('[DecibelService] Stopping voice capture...');

    await _recorder.stopRecorder();
    isCapturing.value = false;

    // On web, just return the path (flutter_sound handles storage)
    // On native, verify file exists
    if (_captureFilePath != null) {
      if (kIsWeb) {
        debugPrint(
            '[DecibelService] Voice capture saved (web): $_captureFilePath');
        return _captureFilePath;
      } else if (await File(_captureFilePath!).exists()) {
        debugPrint(
            '[DecibelService] Voice capture saved to: $_captureFilePath');
        return _captureFilePath;
      }
    }

    return null;
  }

  /// Resume monitoring mode after playback is done
  Future<void> resumeMonitoring() async {
    if (!_isRecorderInitialized || isCapturing.value) return;

    debugPrint('[DecibelService] Resuming monitoring mode...');

    // Small delay to ensure previous recording is fully stopped
    await Future.delayed(const Duration(milliseconds: 100));

    await _startMonitoring();
  }

  /// Pause monitoring (used during playback to prevent feedback)
  Future<void> pauseMonitoring() async {
    if (!_isRecorderInitialized || isCapturing.value) return;

    debugPrint('[DecibelService] Pausing monitoring...');
    await _recorder.stopRecorder();
    decibelLevel.value = 0.0;
    weightedDecibelLevel.value = 0.0;
  }

  @override
  void onClose() {
    _recorderSubscription?.cancel();
    _recorder.stopRecorder();
    _recorder.closeRecorder();
    super.onClose();
  }
}

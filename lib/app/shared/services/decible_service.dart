import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class DecibelService extends GetxService {
  static DecibelService get to => Get.find();
  RxDouble decibelLevel = 0.0.obs; // Reactive variable to track decibel level
  RxDouble meanDecibelLevel =
      0.0.obs; // Reactive variable to track mean decibel level
  RxDouble weightedDecibelLevel =
      0.0.obs; // Reactive variable to track weighted decibel level
  List<double> decibelLevels = [];
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;
  StreamSubscription? _recorderSubscription;

  @override
  void onInit() {
    super.onInit();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    // Request microphone permission
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _recorder.openRecorder();
    _isRecorderInitialized = true;

    await _recorder.setSubscriptionDuration(
      const Duration(milliseconds: 100),
    );

    _startRecording();
  }

  void _startRecording() {
    if (!_isRecorderInitialized) return;
    _recorderSubscription =
        _recorder.onProgress!.listen((RecordingDisposition event) {
      double decibels = event.decibels ?? 0.0;
      decibelLevel.value = decibels;
      decibelLevels.add(decibels);

      // Keep only the last 1 second of decibel levels
      if (decibelLevels.length > 10) {
        decibelLevels.removeAt(0);
      }

      // Give more weight to recent values
      double weightedSum = 0;
      double weightTotal = 0;
      for (int i = 0; i < decibelLevels.length; i++) {
        double weight = (i + 1.0); // Increasing weights
        weightedSum += decibelLevels[i] * weight;
        weightTotal += weight;
      }

      weightedDecibelLevel.value = weightedSum / weightTotal;
      meanDecibelLevel.value =
          decibelLevels.reduce((a, b) => a + b) / decibelLevels.length;
      // print('Decibel level: $decibels, Mean decibel level: $meanDecibelLevel');
    });

    _recorder.startRecorder(
      toFile: 'decibel_record.aac',
      codec: Codec.aacMP4,
      sampleRate: 44100,
      numChannels: 1,
    );
  }

  @override
  void onClose() {
    _recorderSubscription?.cancel();
    _recorder.stopRecorder();
    _recorder.closeRecorder();
    super.onClose();
  }
}

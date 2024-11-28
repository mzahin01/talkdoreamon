import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class DecibelService extends GetxService {
  static DecibelService get to => Get.find();
  RxDouble decibelLevel = 0.0.obs; // Reactive variable to track decibel level
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
    _recorderSubscription = _recorder.onProgress!.listen((event) {
      double decibels = event.decibels ?? 0.0;
      decibelLevel.value = decibels;
      // print('Decibel level: $decibels');
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

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';

class SoundService extends GetxService {
  static SoundService get to => Get.find();

  final Codec _codec = Codec.aacMP4;
  final String _mPath = 'tau_file.mp4';
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  RxBool isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
    _initializeRecorder();
  }

  Future<void> _initializePlayer() async {
    await _mPlayer.openPlayer();
    _mPlayerIsInited = true;
  }

  Future<void> _initializeRecorder() async {
    await _mRecorder.openRecorder();
    _mRecorderIsInited = true;
  }

  Future<void> record() async {
    if (_mRecorderIsInited) {
      await _mRecorder.startRecorder(
        toFile: _mPath,
        codec: _codec,
      );
      _mplaybackReady = false;
    }
  }

  Future<void> stopRecording() async {
    if (_mRecorderIsInited) {
      await _mRecorder.stopRecorder();
      _mplaybackReady = true;
    }
  }

  Future<void> play() async {
    if (_mRecorder.isRecording) {
      await stopRecording();
    }
    if (_mPlayerIsInited && _mplaybackReady) {
      isPlaying.value = true;
      await _mPlayer.setSpeed(1.3);
      await _mPlayer.startPlayer(
        fromURI: _mPath,
        codec: _codec,
        whenFinished: () {
          isPlaying.value = false;
        },
      );
    }
  }

  Future<void> stopPlaying() async {
    if (_mPlayerIsInited) {
      await _mPlayer.stopPlayer();
    }
  }

  Future<void> recordAndReplace() async {
    if (_mRecorder.isRecording) {
      await stopRecording();
    }
    await record();
  }

  @override
  void onClose() {
    try {
      _mPlayer.stopPlayer();
      _mRecorder.stopRecorder();
      _mRecorder.closeRecorder();
    } catch (e) {
      debugPrint('Error closing recorder: $e');
    }
    super.onClose();
  }
}

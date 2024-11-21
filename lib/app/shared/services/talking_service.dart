import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';

class SoundService extends GetxService {
  SoundService get to => Get.find();

  final Codec _codec = Codec.aacMP4;
  final String _mPath = 'tau_file.mp4';
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

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
    if (_mPlayerIsInited && _mplaybackReady) {
      await _mPlayer.startPlayer(
        fromURI: _mPath,
        codec: _codec,
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
}

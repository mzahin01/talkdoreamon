import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';

/// Sound playback service for Talking Tom-style voice playback.
/// This service ONLY handles playback - recording is handled by DecibelService.
class SoundService extends GetxService {
  static SoundService get to => Get.find();

  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlayerInitialized = false;

  /// Playback state
  RxBool isPlaying = false.obs;

  /// Playback speed (1.3 = slightly faster/higher pitch like Talking Tom)
  double playbackSpeed = 1.3;

  /// Path to the captured audio file
  String? _audioFilePath;

  /// Get the appropriate codec for the current platform
  Codec get _codec => kIsWeb ? Codec.opusWebM : Codec.aacMP4;

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    await _player.openPlayer();
    _isPlayerInitialized = true;
    debugPrint('[SoundService] Player initialized');
  }

  /// Set the audio file to play (captured from DecibelService)
  void setAudioFile(String? filePath) {
    _audioFilePath = filePath;
    debugPrint('[SoundService] Audio file set: $filePath');
  }

  /// Play the captured audio with pitch shift
  Future<bool> play() async {
    if (!_isPlayerInitialized) {
      debugPrint('[SoundService] Player not initialized');
      return false;
    }

    if (_audioFilePath == null) {
      debugPrint('[SoundService] No audio file to play');
      return false;
    }

    // On native platforms, verify file exists and check size
    if (!kIsWeb) {
      final file = File(_audioFilePath!);
      if (!await file.exists()) {
        debugPrint('[SoundService] Audio file does not exist: $_audioFilePath');
        return false;
      }

      // Check file size (skip very short recordings)
      final fileSize = await file.length();
      if (fileSize < 1000) {
        // Less than 1KB is likely too short
        debugPrint('[SoundService] Audio file too small: $fileSize bytes');
        return false;
      }
      debugPrint(
          '[SoundService] Playing audio: $_audioFilePath (size: $fileSize bytes)');
    } else {
      debugPrint('[SoundService] Playing audio (web): $_audioFilePath');
    }

    isPlaying.value = true;

    try {
      await _player.setSpeed(playbackSpeed);
      await _player.startPlayer(
        fromURI: _audioFilePath,
        codec: _codec,
        whenFinished: () {
          debugPrint('[SoundService] Playback finished');
          isPlaying.value = false;
        },
      );
      return true;
    } catch (e) {
      debugPrint('[SoundService] Error playing audio: $e');
      isPlaying.value = false;
      return false;
    }
  }

  /// Stop playback
  Future<void> stopPlaying() async {
    if (_isPlayerInitialized && isPlaying.value) {
      debugPrint('[SoundService] Stopping playback');
      try {
        await _player.stopPlayer();
      } catch (e) {
        debugPrint('[SoundService] Error stopping player: $e');
      }
      isPlaying.value = false;
    }
  }

  @override
  void onClose() {
    try {
      _player.stopPlayer();
      _player.closePlayer();
    } catch (e) {
      debugPrint('[SoundService] Error closing player: $e');
    }
    super.onClose();
  }
}

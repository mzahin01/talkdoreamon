// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// class TalkingTomService extends GetxService {
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   final FlutterSoundPlayer _player = FlutterSoundPlayer();

//   RxBool isRecording = false.obs;
//   RxBool isPlaying = false.obs;
//   Rx<File?> recordedAudio = Rx<File?>(null);

//   Future<TalkingTomService> init() async {
//     // Request microphone permissions
//     await Permission.microphone.request();
//     await Permission.storage.request();

//     // Initialize recorder and player
//     await _recorder.openRecorder();
//     await _player.openPlayer();

//     return this;
//   }

//   Future<void> startRecording() async {
//     if (await Permission.microphone.isGranted) {
//       final tempDir = await getTempDirectory();
//       final audioPath = '${tempDir.path}/recorded_audio.wav';

//       await _recorder.startRecorder(
//         toFile: audioPath,
//         codec: Codec.pcm16WAV,
//       );

//       isRecording.value = true;
//     }
//   }

//   Future<void> stopRecording() async {
//     final path = await _recorder.stopRecorder();
//     isRecording.value = false;

//     if (path != null) {
//       recordedAudio.value = File(path);
//     }
//   }

//   Future<void> playRecording() async {
//     if (recordedAudio.value != null) {
//       await _player.startPlayer(
//         fromURI: recordedAudio.value!.path,
//         codec: Codec.pcm16WAV,
//         whenFinished: () {
//           isPlaying.value = false;
//         },
//       );
//       isPlaying.value = true;
//     }
//   }

//   Future<void> stopPlaying() async {
//     await _player.stopPlayer();
//     isPlaying.value = false;
//   }

//   Future<Directory> getTempDirectory() async {
//     return Directory.systemTemp;
//   }

//   @override
//   void onClose() {
//     _recorder.closeRecorder();
//     _player.closePlayer();
//     super.onClose();
//   }
// }

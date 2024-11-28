import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DecibelService extends GetxService {
  static DecibelService get to => Get.find();

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  // Reactive variables for monitoring
  RxBool isRecording = false.obs;
  RxDouble currentDecibelLevel = 0.0.obs;
  RxBool isAboveThreshold = false.obs;

  final double threshold;
  StreamSubscription? _recorderSubscription;

  DecibelService({this.threshold = 50.0});

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    // Request microphone permission
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _recorder.openRecorder();
  }

  Future<void> startMonitoring() async {
    if (isRecording.value) return;

    await _recorder.startRecorder(
      codec: Codec.pcm16WAV,
      toStream: null,
    );

    _recorderSubscription =
        _recorder.onProgress?.listen((RecordingDisposition disposition) {
      double decibels = disposition.decibels ?? 0.0;

      // Update current decibel level
      currentDecibelLevel.value = decibels;

      // Check threshold and update state
      bool nowAboveThreshold = decibels > threshold;
      if (nowAboveThreshold != isAboveThreshold.value) {
        isAboveThreshold.value = nowAboveThreshold;

        // Optional: Add custom logic when threshold changes
        if (nowAboveThreshold) {
          print('Decibel level exceeded $threshold dB');
        } else {
          print('Decibel level dropped below $threshold dB');
        }
      }
    });

    isRecording.value = true;
  }

  Future<void> stopMonitoring() async {
    await _recorderSubscription?.cancel();
    await _recorder.stopRecorder();

    // Reset values
    isRecording.value = false;
    currentDecibelLevel.value = 0.0;
    isAboveThreshold.value = false;
  }

  @override
  Future<void> onClose() async {
    await stopMonitoring();
    await _recorder.closeRecorder();
    super.onClose();
  }
}

// // Example Usage in a Widget
// class DecibelMonitorWidget extends StatelessWidget {
//   final DecibelService _decibelService = Get.put(DecibelService(threshold: 50.0));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(() => Text(
//               'Current Decibel Level: ${_decibelService.currentDecibelLevel.value.toStringAsFixed(2)}',
//             )),
//             Obx(() => Text(
//               'Above Threshold: ${_decibelService.isAboveThreshold.value}',
//             )),
//             ElevatedButton(
//               onPressed: () => _decibelService.isRecording.value 
//                 ? _decibelService.stopMonitoring() 
//                 : _decibelService.startMonitoring(),
//               child: Obx(() => Text(
//                 _decibelService.isRecording.value 
//                   ? 'Stop Monitoring' 
//                   : 'Start Monitoring'
//               )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
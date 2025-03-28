import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:rive/src/core/core.dart';

class TestPageController extends GetxController {
  SMIInput<bool>? hearInput;
  SMIInput<bool>? sadInput;
  LinearAnimation? timeline;
  StateMachineController? controller;

  void onTestRiveInit(Artboard artboard) {
    // Get state machine controller
    controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );

    if (controller != null) {
      artboard.addController(controller!);
      hearInput = controller!.findInput<bool>('hear');
    }

    sadInput = artboard.getBoolInput('sad', 'mouth');

    // Get reference to Timeline 1 animation
    timeline = artboard.animations
            .firstWhereOrNull((anim) => anim.name == 'Timeline 1')
        as LinearAnimation?;
  }

  // Call this method to seek to frame 32
  void seekToFrame32() {
    if (timeline != null && controller != null) {
      // Calculate time from frame (assuming standard 60fps)
      double timeInSeconds = 50 / 60; // 32nd frame at 60fps

      // Create a temporary animation instance
      final instance = LinearAnimationInstance(timeline!);
      instance.time = timeInSeconds;
      instance.apply(controller!.artboard as CoreContext, mix: 1.0);
    }
  }

  void seekToPosition(double timeInSeconds) {
    if (timeline != null && controller != null) {
      final instance = LinearAnimationInstance(timeline!);
      instance.time = timeInSeconds;
      instance.apply(controller!.artboard as CoreContext, mix: 1.0);
    }
  }
}

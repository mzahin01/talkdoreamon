import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeController extends GetxController {
  void onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
      // onStateChange: _onStateChange,
    );
    artboard.addController(controller!);
  }
}

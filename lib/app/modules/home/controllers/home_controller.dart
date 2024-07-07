import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeController extends GetxController {
  SMIInput<bool>? _speakInput;
  SMIInput<bool>? _sAndOInput;
  SMIInput<bool>? _thoughtInput;
  SMIInput<bool>? _hiDoremonInput;
  SMIInput<bool>? _sunnahSmileInput;

  void onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    if (controller != null) {
      artboard.addController(controller);

      // Find inputs by name and store references
      _speakInput = controller.findInput<bool>('Speak');
      _sAndOInput = controller.findInput<bool>('S&O');
      _thoughtInput = controller.findInput<bool>('Thought');
      _hiDoremonInput = controller.findInput<bool>('HiDoremon');
      _sunnahSmileInput = controller.findInput<bool>('SunnahSmile');
    }
  }

  // Functions to trigger inputs
  void triggerSpeak() => _speakInput?.value = true;
  void triggerSAndO() => _sAndOInput?.value = true;
  void triggerThought() => _thoughtInput?.value = true;
  void triggerHiDoremon() => _hiDoremonInput?.value = true;
  void triggerSunnahSmile() => _sunnahSmileInput?.value = true;
}

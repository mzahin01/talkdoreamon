// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeController extends GetxController {
  RxBool GadBool = true.obs;

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

      // Log the inputs to verify they are correctly found
      print('Speak Input: $_speakInput');
      print('S&O Input: $_sAndOInput');
      print('Thought Input: $_thoughtInput');
      print('HiDoremon Input: $_hiDoremonInput');
      print('SunnahSmile Input: $_sunnahSmileInput');
    } else {
      print('Error: StateMachineController is null');
    }
  }

  // Functions to trigger inputs
  void triggerSpeak() {
    if (_speakInput != null) {
      _speakInput!.value = true;
      print('Speak input triggered');
    } else {
      print('Error: Speak input is null');
    }
  }

  void triggerSAndO() {
    if (_sAndOInput != null) {
      _sAndOInput!.value = true;
      GadBool.value = !GadBool.value;
      print('S&O input triggered, GadBool: ${GadBool.value}');
    } else {
      print('Error: S&O input is null');
    }
  }

  void triggerThought() {
    if (_thoughtInput != null) {
      _thoughtInput!.value = true;
      print('Thought input triggered');
    } else {
      print('Error: Thought input is null');
    }
  }

  void triggerHiDoremon() {
    if (_hiDoremonInput != null) {
      _hiDoremonInput!.value = true;
      print('HiDoremon input triggered');
    } else {
      print('Error: HiDoremon input is null');
    }
  }

  void triggerSunnahSmile() {
    if (_sunnahSmileInput != null) {
      _sunnahSmileInput!.value = true;
      print('SunnahSmile input triggered');
    } else {
      print('Error: SunnahSmile input is null');
    }
  }
}

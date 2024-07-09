// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeController extends GetxController {
  RxBool GadBool = true.obs;
  RxDouble AnimeContHeight = 30.0.obs;
  RxDouble AnimeContWidth = 30.0.obs;
  RxDouble AnimeBottMargin = 30.0.obs;

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
      _speakInput = controller.findInput<bool>('Speak');
      _sAndOInput = controller.findInput<bool>('S&O');
      _thoughtInput = controller.findInput<bool>('Thought');
      _hiDoremonInput = controller.findInput<bool>('HiDoremon');
      _sunnahSmileInput = controller.findInput<bool>('SunnahSmile');
    }
  }

  void triggerSpeak() {
    if (_speakInput != null) {
      _speakInput!.value = true;
    }
  }

  void triggerSAndO() {
    _sAndOInput!.value = true;
    Future.delayed(const Duration(milliseconds: 1400), () {
      AnimeContHeight.value = 200;
      AnimeContWidth.value = 275;
      AnimeBottMargin.value = 190;
    });
    Future.delayed(const Duration(milliseconds: 3400), () {
      AnimeContHeight.value = 30;
      AnimeContWidth.value = 30;
      AnimeBottMargin.value = 30;
    });
  }

  void triggerThought() {
    _thoughtInput!.value = true;
  }

  void triggerHiDoremon() {
    _hiDoremonInput!.value = true;
  }

  void triggerSunnahSmile() {
    _sunnahSmileInput!.value = true;
  }
}

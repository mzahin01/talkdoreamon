// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeController extends GetxController {
  RxDouble AnimeContHeight = 30.0.obs;
  RxDouble AnimeContWidth = 30.0.obs;
  RxDouble AnimeBottMargin = 30.0.obs;
  RxInt AnimeDuration = 300.obs;
  RxString MyArtboard = 'Usual'.obs;

  SMIInput<bool>? _speakInput;
  SMIInput<bool>? _sAndOInput;
  SMIInput<bool>? _thoughtInput;
  SMIInput<bool>? _hiDoremonInput;
  SMIInput<bool>? _sunnahSmileInput;

  void onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'Usual',
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
    triggerThought();
    AnimeContHeight.value = 0;
    AnimeContWidth.value = 0;
    AnimeBottMargin.value = 30;
    AnimeDuration.value = 300;
    _sAndOInput!.value = true;
    Future.delayed(const Duration(milliseconds: 2700), () {
      triggerThought();
      AnimeContHeight.value = 200;
      AnimeContWidth.value = 275;
      AnimeBottMargin.value = 190;
    });
    Future.delayed(const Duration(milliseconds: 5400), () {
      AnimeContHeight.value = 30;
      AnimeContWidth.value = 30;
      AnimeBottMargin.value = 2000;
    });
  }

  void triggerEat() {
    if (MyArtboard.value == 'Usual') {
      MyArtboard.value == 'DoraCake';
    } else {
      MyArtboard.value = 'Usual';
    }
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

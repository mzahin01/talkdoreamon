// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomeController extends GetxController {
  RxDouble AnimeContHeight = 50.0.obs;
  RxDouble AnimeContWidth = 100.0.obs;
  RxDouble AnimeBottMargin = 170.0.obs;
  RxInt AnimeDuration = 300.obs;

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

  Future<void> triggerSAndO() async {
    triggerThought();
    AnimeContHeight.value = 0;
    AnimeContWidth.value = 0;
    AnimeBottMargin.value = 30;
    AnimeDuration.value = 300;
    _sAndOInput!.value = true;
    await Future.delayed(const Duration(milliseconds: 1700), () {
      triggerThought();
    });
    await Future.delayed(const Duration(milliseconds: 1000), () {
      AnimeContHeight.value = 200;
      AnimeContWidth.value = 275;
      AnimeBottMargin.value = 230;
      AnimeDuration.value = 250;
    });
    await Future.delayed(const Duration(milliseconds: 5400), () {
      AnimeContHeight.value = 30;
      AnimeContWidth.value = 30;
      AnimeBottMargin.value = 2000;
      AnimeDuration.value = 50;
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

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
  SMIInput<bool>? _doracake;
  SMIInput<bool>? _hellCandy;
  SMIInput<bool>? _iceCream;
  SMIInput<bool>? _chicken;
  SMIInput<bool>? _strawberry;
  SMIInput<bool>? _redApple;

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
      _doracake = controller.findInput<bool>('DoraCake');
      _chicken = controller.findInput<bool>('Chicken');
      _strawberry = controller.findInput<bool>('Strawberry');
      _redApple = controller.findInput<bool>('RedApple');
      _hellCandy = controller.findInput<bool>('HellCandy');
      _iceCream = controller.findInput<bool>('IceCream');
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
    await Future.delayed(const Duration(milliseconds: 2000), () {
      triggerThought();
    });
    await Future.delayed(const Duration(milliseconds: 700), () {
      AnimeContHeight.value = 600;
      AnimeContWidth.value = 300;
      AnimeBottMargin.value = 250;
      AnimeDuration.value = 250;
    });
    await Future.delayed(const Duration(milliseconds: 2000), () {
      AnimeContHeight.value = 30;
      AnimeContWidth.value = 30;
      AnimeBottMargin.value = 2000;
      AnimeDuration.value = 300;
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

  void Doracake() {
    _doracake!.value = true;
  }

  void IceCream() {
    _iceCream!.value = true;
  }

  void Chicken() {
    _chicken!.value = true;
  }

  void Strawberry() {
    _strawberry!.value = true;
  }

  void HellCandy() {
    _hellCandy!.value = true;
  }

  void RedApple() {
    _redApple!.value = true;
  }
}

// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:rive/rive.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart' as cia;

import '../../../shared/services/decible_service.dart';
import '../../../shared/services/sound_service.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  // Background Images List
  List<String> bgList = [
    cia.ImageAsset.background0,
    cia.ImageAsset.background1,
    cia.ImageAsset.background2,
    cia.ImageAsset.background3,
    cia.ImageAsset.background4,
    cia.ImageAsset.background5,
    cia.ImageAsset.background6,
  ];

  // Infinite Carousel Controller
  late InfiniteScrollController scrollController;

  @override
  void onInit() {
    super.onInit();

    scrollController = InfiniteScrollController();

    // Keep printing the decibel level
    ever(DecibelService.to.decibelLevel, (_) {
      handleSpeaking();
    });
  }

  double threshold = 50.0;
  bool isListening = false;

  double get decibelLevel => DecibelService.to.decibelLevel.value;
  Future<void> handleSpeaking() async {
    if (decibelLevel > threshold && !isListening) {
      await Future.delayed(const Duration(seconds: 1));
      if (decibelLevel > threshold) {
        triggerListenToggle();
        recordSound();
        isListening = true;
      }
    }
    if (decibelLevel < threshold && isListening) {
      await Future.delayed(const Duration(seconds: 1));
      if (decibelLevel < threshold) {
        triggerListenToggle();
        triggerSpeak();
        await playSound();
        triggerSpeak();
        isListening = false;
      }
    }
    print('Current decibel level: $decibelLevel');
  }

  // Function to record sound
  Future<void> recordSound() async {
    SoundService.to.getRecorderFn();
  }

  // Function to play sound
  Future<void> playSound() async {
    await SoundService.to.play();
  }

  // Carousel Navigation Methods
  void next() {
    scrollController.nextItem();
  }

  void back() {
    scrollController.previousItem();
  }

  // Animation-related Observables
  RxDouble AnimeContHeight = 50.0.obs;
  RxDouble AnimeContWidth = 100.0.obs;
  RxDouble AnimeBottMargin = 170.0.obs;
  RxInt AnimeDuration = 300.obs;

  // Food-related Observables
  RxDouble foodContHeight = 50.0.obs;
  RxDouble foodContWidth = 100.0.obs;
  RxDouble foodRightMargin = 10.0.obs;
  RxInt foodDuration = 300.obs;

  // Toggle state for animation
  RxBool isFirstFunctionActive = true.obs;

  // Animation State Control Variables
  bool animating = false;

  // Rive SMIInputs (State Machine Inputs) for different actions
  SMIInput<bool>? _flyInput;
  SMIInput<bool>? _travelInput;
  SMIInput<bool>? _chillinInput;
  SMIInput<bool>? _listenToggleInput;
  SMIInput<bool>? _noEatInput;
  SMIInput<bool>? _eatInput;
  SMIInput<bool>? _rightLegPunchInput;
  SMIInput<bool>? _leftLegPunchInput;
  SMIInput<bool>? _headPunchInput;
  SMIInput<bool>? _trunkPunchInput;
  SMIInput<bool>? _rightHandPunchInput;
  SMIInput<bool>? _leftHandPunchInput;
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

  // Toggle Function to Switch Between Two States
  Future<void> triggerFoodAnimation() async {
    if (isFirstFunctionActive.value) {
      // First function state
      foodContHeight.value = 100;
      foodContWidth.value = Get.width * 2 / 3;
      foodRightMargin.value = Get.width;
      foodDuration.value = 250;
    } else {
      // Second function state
      foodContHeight.value = 100;
      foodContWidth.value = Get.width * 2 / 3;
      foodRightMargin.value = 30;
      foodDuration.value = 300;
    }

    // Toggle the state for the next call
    isFirstFunctionActive.value = !isFirstFunctionActive.value;
  }

  // Rive State Machine Initialization
  void onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'Usual',
    );
    if (controller != null) {
      artboard.addController(controller);

      // Initialize the SMIInputs
      _speakInput = controller.findInput<bool>('Speak');
      _sAndOInput = controller.findInput<bool>('S&O');
      _thoughtInput = controller.findInput<bool>('Thought');
      _hiDoremonInput = controller.findInput<bool>('Hi');
      _sunnahSmileInput = controller.findInput<bool>('SunnahSmile');
      _doracake = controller.findInput<bool>('DoraCake');
      _chicken = controller.findInput<bool>('Chicken');
      _strawberry = controller.findInput<bool>('Strawberry');
      _redApple = controller.findInput<bool>('RedApple');
      _hellCandy = controller.findInput<bool>('HellCandy');
      _iceCream = controller.findInput<bool>('IceCream');
      _flyInput = controller.findInput<bool>('fly');
      _travelInput = controller.findInput<bool>('Travel');
      _chillinInput = controller.findInput<bool>('Chillin');
      _listenToggleInput = controller.findInput<bool>('ListenToggle');
      _noEatInput = controller.findInput<bool>('noEat');
      _eatInput = controller.findInput<bool>('Eat');
      _rightLegPunchInput = controller.findInput<bool>('RightLegPunch');
      _leftLegPunchInput = controller.findInput<bool>('LeftLegPunch');
      _headPunchInput = controller.findInput<bool>('HeadPunch');
      _trunkPunchInput = controller.findInput<bool>('TrunkPunch');
      _rightHandPunchInput = controller.findInput<bool>('RightHandPunch');
      _leftHandPunchInput = controller.findInput<bool>('LeftHandPunch');
    }
  }

  // Rive Trigger Methods
  void triggerSpeak() {
    _speakInput?.value = true;
  }

  Future<void> triggerSAndO() async {
    triggerThought();
    AnimeContHeight.value = 0;
    AnimeContWidth.value = 0;
    AnimeBottMargin.value = 30;
    AnimeDuration.value = 300;
    _sAndOInput?.value = true;

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

  Future<void> triggerFly() async {
    if (animating) {
      return;
    } else {
      await Future.delayed(const Duration(milliseconds: 0), () {
        animating = true;
        _flyInput?.value = true;
      });
      await Future.delayed(const Duration(milliseconds: 3000), () {
        back();
      });
      await Future.delayed(const Duration(milliseconds: 200), () {
        _flyInput?.value = true;
      });
      await Future.delayed(const Duration(milliseconds: 2300), () {
        animating = false;
      });
    }
  }

  Future<void> triggerTravel() async {
    if (animating) {
      return;
    } else {
      await Future.delayed(const Duration(milliseconds: 0), () {
        animating = true;
        // triggerSAndO();
      });
      await Future.delayed(const Duration(milliseconds: 0), () {
        _travelInput?.value = true;
      });
      await Future.delayed(const Duration(milliseconds: 700), () {
        next();
      });
      await Future.delayed(const Duration(milliseconds: 0), () {
        animating = false;
      });
    }
  }

  void triggerChillin() {
    _chillinInput?.value = true;
  }

  void triggerListenToggle() {
    _listenToggleInput?.value = true;
  }

  void triggerNoEat() {
    _noEatInput?.value = true;
  }

  void triggerEat() {
    _eatInput?.value = true;
  }

  void triggerRightLegPunch() {
    _rightLegPunchInput?.value = true;
  }

  void triggerLeftLegPunch() {
    _leftLegPunchInput?.value = true;
  }

  void triggerHeadPunch() {
    _headPunchInput?.value = true;
  }

  void triggerTrunkPunch() {
    _trunkPunchInput?.value = true;
  }

  void triggerRightHandPunch() {
    _rightHandPunchInput?.value = true;
  }

  void triggerLeftHandPunch() {
    _leftHandPunchInput?.value = true;
  }

  void triggerThought() {
    _thoughtInput?.value = true;
  }

  void triggerHiDoremon() {
    _hiDoremonInput?.value = true;
  }

  void triggerSunnahSmile() {
    _sunnahSmileInput?.value = true;
  }

  void Doracake() {
    _doracake?.value = true;
  }

  void IceCream() {
    _iceCream?.value = true;
  }

  void Chicken() {
    _chicken?.value = true;
  }

  void Strawberry() {
    _strawberry?.value = true;
  }

  void HellCandy() {
    _hellCandy?.value = true;
  }

  void RedApple() {
    _redApple?.value = true;
  }
}

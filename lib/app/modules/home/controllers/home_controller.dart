// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:async';

import 'package:flutter/foundation.dart';
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
    DecibelService.to.weightedDecibelLevel.listen(decideToListenAndSpeak);
    SoundService.to.isPlaying.listen(stopSpeakingAndStartCooldown);
    // Monitor and adjust threshold based on ambient noise
    Timer.periodic(const Duration(seconds: 10), (timer) {
      _updateAmbientThreshold();
    });
  }

  void _updateAmbientThreshold() {
    if (ambientLevels.length >= 20) {
      // Calculate ambient noise level (exclude outliers)
      ambientLevels.sort();
      var relevantSamples = ambientLevels.sublist(5, ambientLevels.length - 5);
      var ambientNoise =
          relevantSamples.reduce((a, b) => a + b) / relevantSamples.length;

      // Set threshold dynamically (ambient + margin)
      threshold.value = ambientNoise + 10.0;

      debugPrint(
          '${DateTime.now()} ------- Updated threshold: ${threshold.value}');

      // Clear for next cycle
      ambientLevels.clear();
    }
  }

  void stopSpeakingAndStartCooldown(isPlayingSoundService) {
    if (isSpeaking && !isPlayingSoundService) {
      // End speaking
      isSpeaking = false;
      SoundService.to.stopPlaying();
      triggerSpeakFalse();
      print('=== ENDED SPEAKING ===');

      // Start cooldown period
      _startCooldown();
    }
  }

  RxDouble threshold = 50.0.obs;
  List<double> ambientLevels = [];

  bool isListening = false;
  bool isSpeaking = false;
  int consecutiveLoudSamples = 0;
  int consecutiveSilentSamples = 0;
  Timer? cooldownTimer;

  void decideToListenAndSpeak(double meanDb) async {
    // Add to ambient levels when not speaking or listening
    if (!isListening && !isSpeaking && cooldownTimer == null) {
      ambientLevels.add(meanDb);
    }

    // Cooldown period after speaking
    if (cooldownTimer != null && cooldownTimer!.isActive) {
      return;
    }

    // Speech detection logic
    if (!isListening && !isSpeaking) {
      if (meanDb > threshold.value) {
        consecutiveLoudSamples++;
        consecutiveSilentSamples = 0;

        // Wait for 3 consecutive loud samples (300ms) to confirm speech
        if (consecutiveLoudSamples >= 3) {
          _startListening();
        }
      } else {
        consecutiveLoudSamples = 0;
      }
    }

    // While listening, check for silence to stop recording
    if (isListening) {
      if (meanDb < threshold.value) {
        consecutiveSilentSamples++;

        // Wait for 5 consecutive silent samples (500ms) to confirm speech end
        if (consecutiveSilentSamples >= 5) {
          await _stopListeningAndRespond();
        }
      } else {
        consecutiveSilentSamples = 0;
      }
    }
  }

  Future<void> _startListening() async {
    isListening = true;
    consecutiveLoudSamples = 0;
    print('=== STARTED LISTENING ===');
    await SoundService.to.recordAndReplace();
    triggerListenTrue();
    // Start recording
    // triggerListenToggle();
    // recordSound();
  }

  Future<void> _stopListeningAndRespond() async {
    isListening = false;
    print('=== ENDED LISTENING ===');
    triggerListenFalse();
    await SoundService.to.stopRecording();

    // // Process recorded audio
    // print('=== STARTED PROCESSING ===');
    // // await processAudio();
    // print('=== ENDED PROCESSING ===');

    // Start speaking
    isSpeaking = true;
    print('=== STARTED SPEAKING ===');
    SoundService.to.play();
    triggerSpeakTrue();

    // await playModifiedAudio();
  }

  void _startCooldown() {
    print('=== COOLDOWN STARTED ===');
    cooldownTimer = Timer(const Duration(seconds: 1), () {
      print('=== COOLDOWN ENDED ===');
    });
  }

  // Future<void> handleSpeaking() async {
  //   if (isListening || isSpeaking) {
  //     return;
  //   }
  //   if (meanDecibelLevel < threshold && CycleOn) {
  //     isSpeaking = true;
  //     triggerListenToggle();
  //     triggerSpeak();
  //     await playSound();
  //     // the play sound method is asynchronous, but the sound duration is not
  //     triggerSpeak();
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     isSpeaking = false;
  //     CycleOn = false;
  //   }
  //   // print('Current decibel level: $decibelLevel');
  // }

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
  void triggerSpeakTrue() {
    _speakInput?.value = true;
  }

  void triggerSpeakFalse() {
    _speakInput?.value = false;
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

  void triggerListenTrue() {
    _listenToggleInput?.value = true;
  }

  void triggerListenFalse() {
    _listenToggleInput?.value = false;
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

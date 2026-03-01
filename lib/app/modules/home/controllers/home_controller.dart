// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rive/rive.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart' as cia;

import '../../../shared/services/decible_service.dart';
import '../../../shared/services/sound_service.dart';
// ignore: implementation_imports
import 'package:rive/src/rive_core/state_machine_controller.dart' as core;

/// Talking Tom-style state machine states
enum TalkingState {
  idle, // Monitoring ambient noise, waiting for speech
  listening, // Recording user's voice
  speaking, // Playing back the recorded voice
  cooldown, // Brief pause after speaking
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Timer? recordingTimeoutTimer;
  Timer? cooldownTimer;
  Timer? ambientUpdateTimer;

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

  // Gadget Images List
  List<String> gadgetList = [
    cia.ImageAsset.anywhereDoor,
    cia.ImageAsset.memory_bread,
    cia.ImageAsset.shrink_ray,
    cia.ImageAsset.timeMachine,
    cia.ImageAsset.bamboo_copter,
  ].obs;

  RxInt gadgetIndex = 0.obs;

  gadgetIndexChanged() {
    gadgetIndex.value = (DateTime.now().millisecondsSinceEpoch % 5).toInt();
  }

  // Infinite Carousel Controller
  late InfiniteScrollController scrollController;
  late AudioPlayer _audioPlayer;

  // ============= TALKING SYSTEM STATE =============

  /// Current state of the talking system
  Rx<TalkingState> talkingState = TalkingState.idle.obs;

  /// Dynamic threshold for voice detection (adjusts to ambient noise)
  RxDouble threshold = 50.0.obs;

  /// Collected ambient noise levels for threshold calculation
  List<double> ambientLevels = [];

  /// Counter for consecutive loud samples (to confirm speech start)
  int consecutiveLoudSamples = 0;

  /// Counter for consecutive silent samples (to confirm speech end)
  int consecutiveSilentSamples = 0;

  /// Margin above ambient noise for threshold
  static const double thresholdMargin = 10.0;

  /// Minimum consecutive loud samples to start listening (300ms)
  static const int minLoudSamples = 3;

  /// Minimum consecutive silent samples to stop listening (500ms)
  static const int minSilentSamples = 5;

  /// Maximum recording duration in seconds
  static const int maxRecordingDuration = 10;

  /// Cooldown duration after speaking in milliseconds
  static const int cooldownDuration = 1000;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setAsset('assets/audio/manyToing.mp3');
    _audioPlayer.setAsset('assets/audio/toing_real.mp3');
    _audioPlayer.setAsset('assets/audio/yeah.mp3');
    scrollController = InfiniteScrollController();

    // Setup the talking system
    _setupTalkingSystem();
  }

  void _setupTalkingSystem() {
    // Set up decibel callback for voice detection
    DecibelService.to.onDecibelUpdate = _onDecibelUpdate;

    // Listen to playback state changes
    SoundService.to.isPlaying.listen(_onPlaybackStateChanged);

    // Monitor and adjust threshold based on ambient noise
    ambientUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateAmbientThreshold();
    });

    debugPrint('[TalkingSystem] Initialized');
  }

  /// Called when decibel level is updated
  void _onDecibelUpdate(double meanDb) {
    switch (talkingState.value) {
      case TalkingState.idle:
        _handleIdleState(meanDb);
        break;
      case TalkingState.listening:
        _handleListeningState(meanDb);
        break;
      case TalkingState.speaking:
      case TalkingState.cooldown:
        // Ignore audio input during speaking and cooldown
        break;
    }
  }

  /// Handle voice detection in idle state
  void _handleIdleState(double meanDb) {
    // Collect ambient levels for threshold calculation
    ambientLevels.add(meanDb);

    // Check for speech
    if (meanDb > threshold.value) {
      consecutiveLoudSamples++;
      consecutiveSilentSamples = 0;

      // Wait for consecutive loud samples to confirm speech start
      if (consecutiveLoudSamples >= minLoudSamples) {
        _startListening();
      }
    } else {
      consecutiveLoudSamples = 0;
    }
  }

  /// Handle silence detection in listening state
  void _handleListeningState(double meanDb) {
    if (meanDb < threshold.value) {
      consecutiveSilentSamples++;

      // Wait for consecutive silent samples to confirm speech end
      if (consecutiveSilentSamples >= minSilentSamples) {
        _stopListeningAndRespond();
      }
    } else {
      consecutiveSilentSamples = 0;
    }
  }

  /// Update threshold based on ambient noise
  void _updateAmbientThreshold() {
    if (talkingState.value != TalkingState.idle) {
      // Only update threshold when idle
      return;
    }

    if (ambientLevels.length >= 10) {
      // Calculate ambient noise level (exclude outliers)
      ambientLevels.sort();
      var relevantSamples = ambientLevels.sublist(2, ambientLevels.length - 2);
      var ambientNoise =
          relevantSamples.reduce((a, b) => a + b) / relevantSamples.length;

      // Set threshold dynamically (ambient + margin)
      threshold.value = ambientNoise + thresholdMargin;

      debugPrint(
          '[TalkingSystem] Updated threshold: ${threshold.value.toStringAsFixed(1)} (ambient: ${ambientNoise.toStringAsFixed(1)})');

      // Clear for next cycle
      ambientLevels.clear();
    }
  }

  /// Called when playback state changes
  void _onPlaybackStateChanged(bool isPlaying) {
    if (talkingState.value == TalkingState.speaking && !isPlaying) {
      // Playback finished
      _onSpeakingFinished();
    }
  }

  /// Start listening/recording
  Future<void> _startListening() async {
    if (talkingState.value != TalkingState.idle) return;

    debugPrint('[TalkingSystem] === STARTED LISTENING ===');

    talkingState.value = TalkingState.listening;
    consecutiveLoudSamples = 0;
    consecutiveSilentSamples = 0;

    // Start capturing voice using DecibelService
    await DecibelService.to.startCapture();

    // Trigger listening animation
    triggerListenTrue();

    // Start a timeout timer to prevent endless recording
    recordingTimeoutTimer =
        Timer(const Duration(seconds: maxRecordingDuration), () {
      if (talkingState.value == TalkingState.listening) {
        debugPrint('[TalkingSystem] === RECORDING TIMEOUT ===');
        _stopListeningAndRespond();
      }
    });
  }

  /// Stop listening and start playback
  Future<void> _stopListeningAndRespond() async {
    if (talkingState.value != TalkingState.listening) return;

    // Cancel the timeout timer
    recordingTimeoutTimer?.cancel();
    recordingTimeoutTimer = null;

    debugPrint('[TalkingSystem] === ENDED LISTENING ===');

    // Stop listening animation
    triggerListenFalse();

    // Stop capturing and get the audio file path
    final audioPath = await DecibelService.to.stopCapture();

    if (audioPath != null) {
      // Set the audio file for playback
      SoundService.to.setAudioFile(audioPath);

      // Pause decibel monitoring during playback (prevent feedback)
      await DecibelService.to.pauseMonitoring();

      // Start speaking
      talkingState.value = TalkingState.speaking;
      debugPrint('[TalkingSystem] === STARTED SPEAKING ===');

      // Trigger speak animation
      triggerSpeakTrue();

      // Play the audio
      final played = await SoundService.to.play();

      if (!played) {
        // Playback failed, go directly to cooldown
        debugPrint('[TalkingSystem] Playback failed, entering cooldown');
        _onSpeakingFinished();
      }
    } else {
      // No audio captured, go back to idle
      debugPrint('[TalkingSystem] No audio captured, returning to idle');
      talkingState.value = TalkingState.idle;
      await DecibelService.to.resumeMonitoring();
    }
  }

  /// Called when speaking/playback is finished
  Future<void> _onSpeakingFinished() async {
    debugPrint('[TalkingSystem] === ENDED SPEAKING ===');

    // Stop speak animation
    triggerSpeakFalse();

    // Enter cooldown state
    talkingState.value = TalkingState.cooldown;
    debugPrint('[TalkingSystem] === COOLDOWN STARTED ===');

    // Start cooldown timer
    cooldownTimer =
        Timer(const Duration(milliseconds: cooldownDuration), () async {
      debugPrint('[TalkingSystem] === COOLDOWN ENDED ===');

      // Resume decibel monitoring
      await DecibelService.to.resumeMonitoring();

      // Reset counters
      consecutiveLoudSamples = 0;
      consecutiveSilentSamples = 0;
      ambientLevels.clear();

      // Return to idle state
      talkingState.value = TalkingState.idle;
    });
  }

  @override
  void onClose() {
    recordingTimeoutTimer?.cancel();
    cooldownTimer?.cancel();
    ambientUpdateTimer?.cancel();
    super.onClose();
  }

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
  bool debouncerActive = false;

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

  // Rive State Machine Initialization
  void onRiveInit(Artboard artboard) {
    final controller = CustomStateMachineController.fromArtboard(
      artboard,
      'Usual',
      onInputChanged: (id, value) {
        // print('callback id: $id');
        // print('numberInput id: ${_headPunchInput?.id}');

        if (id == _headPunchInput?.id ||
            id == _rightLegPunchInput?.id ||
            id == _leftLegPunchInput?.id ||
            id == _trunkPunchInput?.id ||
            id == _rightHandPunchInput?.id ||
            id == _leftHandPunchInput?.id) {
          _audioPlayer.setAsset('assets/audio/toing_real.mp3');
          _audioPlayer.play();
        }
      },
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
      // updateButtonStates();

      // controller.addEventListener((RiveEvent name) {
      //   debugPrint(name.name);
      // });
    }
  }

  // void updateButtonStates() {
  //   // Monitor punch inputs continuously
  //   [
  //     _rightLegPunchInput,
  //     _leftLegPunchInput,
  //     _headPunchInput,
  //     _trunkPunchInput,
  //     _rightHandPunchInput,
  //     _leftHandPunchInput
  //   ].forEach((input) {
  //     if (input?.value == true) {
  //       // Play punch sound
  //       _audioPlayer.seek(Duration.zero);
  //       _audioPlayer.play();
  //       // Reset the input after a short delay
  //       Future.delayed(const Duration(milliseconds: 100), () {
  //         input?.value = false;
  //       });
  //     }
  //   });
  // }

  // Rive Trigger Methods
  void triggerSpeakTrue() {
    _speakInput?.value = true;
  }

  void triggerSpeakFalse() {
    _speakInput?.value = false;
  }

  Future<void> triggerSAndO() async {
    if (debouncerActive) {
      return;
    } else {
      await Future.delayed(const Duration(milliseconds: 0), () async {
        debouncerActive = true;
        _audioPlayer.setAsset('assets/audio/yeah.mp3');
        _audioPlayer.play();
        triggerThought();
        AnimeContHeight.value = 0;
        AnimeContWidth.value = 0;
        AnimeBottMargin.value = 30;
        AnimeDuration.value = 300;
        _sAndOInput?.value = true;
      });
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
      await Future.delayed(const Duration(milliseconds: 500), () {
        debouncerActive = false;
      });
    }
  }

  Future<void> triggerFly() async {
    if (debouncerActive) {
      return;
    } else {
      await Future.delayed(const Duration(milliseconds: 0), () {
        debouncerActive = true;
        _flyInput?.value = true;
      });
      await Future.delayed(const Duration(milliseconds: 3000), () {
        back();
      });
      await Future.delayed(const Duration(milliseconds: 200), () {
        _flyInput?.value = true;
      });
      await Future.delayed(const Duration(milliseconds: 4000), () {
        debouncerActive = false;
      });
    }
  }

  Future<void> triggerTravel() async {
    if (debouncerActive) {
      return;
    } else {
      await Future.delayed(const Duration(milliseconds: 0), () {
        debouncerActive = true;
      });
      await Future.delayed(const Duration(milliseconds: 0), () {
        _travelInput?.value = true;
      });
      await Future.delayed(const Duration(milliseconds: 700), () {
        next();
      });
      await Future.delayed(const Duration(milliseconds: 1000), () {
        debouncerActive = false;
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

typedef InputChanged = void Function(int id, dynamic value);

class CustomStateMachineController extends StateMachineController {
  CustomStateMachineController(
    super.stateMachine, {
    core.OnStateChange? onStateChange,
    required this.onInputChanged,
  });

  final InputChanged onInputChanged;

  @override
  void setInputValue(int id, value) {
    debugPrint('Changed id: $id,  value: $value');
    for (final input in stateMachine.inputs) {
      if (input.id == id) {
        // Do something with the input
        debugPrint('Found input: $input');
      }
    }
    // Or just pass it back to the calling widget
    onInputChanged.call(id, value);
    super.setInputValue(id, value);
  }

  static CustomStateMachineController? fromArtboard(
    Artboard artboard,
    String stateMachineName, {
    core.OnStateChange? onStateChange,
    required InputChanged onInputChanged,
  }) {
    for (final animation in artboard.animations) {
      if (animation is StateMachine && animation.name == stateMachineName) {
        return CustomStateMachineController(
          animation,
          onStateChange: onStateChange,
          onInputChanged: onInputChanged,
        );
      }
    }
    return null;
  }
}

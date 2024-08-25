// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:rive/rive.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart' as cia;

class HomeController extends GetxController {
  List<String> bannerList = [
    cia.ImageAsset.background0,
    cia.ImageAsset.background1,
    cia.ImageAsset.background2,
    cia.ImageAsset.background3,
    cia.ImageAsset.background4,
    cia.ImageAsset.background5,
    cia.ImageAsset.background6,
  ];

  late InfiniteScrollController scrollController;

  // init function
  @override
  void onInit() {
    super.onInit();
    scrollController = InfiniteScrollController();
  }

  void next() {
    scrollController.nextItem();
  }

  void back() {
    scrollController.previousItem();
  }

  RxDouble AnimeContHeight = 50.0.obs;
  RxDouble AnimeContWidth = 100.0.obs;
  RxDouble AnimeBottMargin = 170.0.obs;
  RxInt AnimeDuration = 300.obs;

  RxDouble foodContHeight = 50.0.obs;
  RxDouble foodContWidth = 100.0.obs;
  RxDouble foodRightMargin = 170.0.obs;
  RxInt foodDuration = 300.obs;

// Variable Declarations
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

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  Future<void> record() async {
    await _recorder.startRecorder(
        toFile:
            '/Volumes/code/delete/cope/hope/Testing/landf/talkdoraemon/assets/svgs');
    await Future.delayed(const Duration(seconds: 5));
    await _recorder.stopRecorder();
  }

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
      _noEatInput = controller.findInput<bool>('NoEat');
      _eatInput = controller.findInput<bool>('Eat');
      _rightLegPunchInput = controller.findInput<bool>('RightLegPunch');
      _leftLegPunchInput = controller.findInput<bool>('LeftLegPunch');
      _headPunchInput = controller.findInput<bool>('HeadPunch');
      _trunkPunchInput = controller.findInput<bool>('TrunkPunch');
      _rightHandPunchInput = controller.findInput<bool>('RightHandPunch');
      _leftHandPunchInput = controller.findInput<bool>('LeftHandPunch');
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

  Future<void> triggerFoodAnimation() async {
    foodContHeight.value = 100;
    foodContWidth.value = 0;
    foodRightMargin.value = 30;
    foodDuration.value = 300;
    _sAndOInput!.value = true;
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    await Future.delayed(const Duration(milliseconds: 700), () {
      foodContHeight.value = 600;
      foodContWidth.value = 300;
      foodRightMargin.value = 250;
      foodDuration.value = 250;
    });
    await Future.delayed(const Duration(milliseconds: 2000), () {
      foodContHeight.value = 100;
      foodContWidth.value = Get.width * 2 / 3;
      foodRightMargin.value = 30;
      foodDuration.value = 300;
    });
  }

// Trigger Functions
  void triggerFly() {
    _flyInput!.value = true;
  }

  void triggerTravel() {
    _travelInput!.value = true;
  }

  void triggerChillin() {
    _chillinInput!.value = true;
  }

  void triggerListenToggle() {
    _listenToggleInput!.value = true;
  }

  void triggerNoEat() {
    _noEatInput!.value = true;
  }

  void triggerEat() {
    _eatInput!.value = true;
  }

  void triggerRightLegPunch() {
    _rightLegPunchInput!.value = true;
  }

  void triggerLeftLegPunch() {
    _leftLegPunchInput!.value = true;
  }

  void triggerHeadPunch() {
    _headPunchInput!.value = true;
  }

  void triggerTrunkPunch() {
    _trunkPunchInput!.value = true;
  }

  void triggerRightHandPunch() {
    _rightHandPunchInput!.value = true;
  }

  void triggerLeftHandPunch() {
    _leftHandPunchInput!.value = true;
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

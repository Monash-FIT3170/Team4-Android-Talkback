import 'package:application/common/tutorial.dart';
import 'package:application/tutorial/three/module/challenge.dart';
import 'package:easy_localization/easy_localization.dart';

TutorialMenu tutorialThree =
    TutorialMenu(title: 'tutorial'.tr(args: ['3']), moduleButtons: [
  TutorialMenuButton(
      title: 'challenge'.tr(), module: const Tutorial3Challenge()),
]);

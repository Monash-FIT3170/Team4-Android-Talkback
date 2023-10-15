import 'package:application/tutorial/four/module/tutorial4_challenge.dart';
import 'package:application/tutorial/four/module/volume_media_control.dart';
import 'package:application/common/tutorial.dart';
import 'package:easy_localization/easy_localization.dart';

TutorialMenu tutorialFour =
    TutorialMenu(title: 'tutorial'.tr(args: ['3']), moduleButtons: [
  TutorialMenuButton(
      title: 'media_volume_control'.tr(),
      module: const MediaVolumeControlPage()),
  // TutorialMenuButton(
  //     title: 'start_stop_media'.tr(), module: const StartStopMediaPage()),
  TutorialMenuButton(
      title: 'challenge'.tr(), module: const Tutorial4ChallengePage()),
]);

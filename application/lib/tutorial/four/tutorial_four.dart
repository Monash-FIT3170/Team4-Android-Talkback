import 'package:application/tutorial/four/module/volume_media_control.dart';
import 'package:application/common/tutorial.dart';
import 'package:easy_localization/easy_localization.dart';

TutorialMenu tutorialFour =
    TutorialMenu(title: 'tutorial'.tr(args: ['4']), moduleButtons: [
  // TutorialMenuButton(title: 'Start and stop media', module: null),
  TutorialMenuButton(
      title: 'media_volume_control'.tr(),
      module: const MediaVolumeControlPage()),
  // TutorialMenuButton(title: 'Challenge', module: null)
]);

import 'package:application/common/tutorial.dart';
import 'package:application/tutorial/two/module/adjust_slider.dart';
import 'package:application/tutorial/two/module/explore_menu.dart';
import 'package:application/tutorial/two/module/go_back.dart';
import 'package:application/tutorial/two/module/scroll.dart';
import 'package:application/tutorial/two/practical/homepage.dart';
import 'package:easy_localization/easy_localization.dart';

TutorialMenu tutorialTwo =
    TutorialMenu(title: 'tutorial'.tr(args: ['1']), moduleButtons: [
  TutorialMenuButton(title: 'tutorial2_go_back'.tr(), module: const GoBack()),
  TutorialMenuButton(
      title: 'tutorial2_scrolling'.tr(),
      module: const VerticalScrollSubmodule()),
  TutorialMenuButton(
      title: 'tutorial2_explore_menu'.tr(), module: const ExploreMenuPage()),
  TutorialMenuButton(
      title: 'tutorial2_adjust_slider'.tr(), module: const AdjustSlider()),
  TutorialMenuButton(
      title: 'practical_application'.tr(), module: const Tutorial2Practical()),
]);

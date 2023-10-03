import 'package:application/common/tutorial.dart';
import 'package:application/tutorial/two/module/adjust_slider.dart';
import 'package:application/tutorial/two/module/explore_menu.dart';
import 'package:application/tutorial/two/module/go_back.dart';
import 'package:application/tutorial/two/module/scroll.dart';
import 'package:easy_localization/easy_localization.dart';

TutorialMenu tutorialTwo =
    TutorialMenu(title: 'tutorial'.tr(args: ['2']), moduleButtons: [
  TutorialMenuButton(title: 'tutorial2_go_back'.tr(), module: GoBack()),
  TutorialMenuButton(
      title: 'tutorial2_scrolling'.tr(), module: VerticalScrollSubmodule()),
  TutorialMenuButton(
      title: 'tutorial2_explore_menu'.tr(), module: ExploreMenuPage()),
  TutorialMenuButton(
      title: 'tutorial2_adjust_slider'.tr(), module: AdjustSlider()),
  // TutorialMenuButton(title: 'Practical application', module: null),
]);

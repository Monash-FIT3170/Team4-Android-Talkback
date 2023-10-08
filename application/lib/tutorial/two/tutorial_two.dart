import 'package:application/common/tutorial.dart';
import 'package:application/tutorial/two/module/adjust_slider.dart';
import 'package:application/tutorial/two/module/explore_menu.dart';
import 'package:application/tutorial/two/module/go_back.dart';
import 'package:application/tutorial/two/module/scroll.dart';

const TutorialMenu tutorialTwo =
    TutorialMenu(title: 'Tutorial 2', moduleButtons: [
  TutorialMenuButton(title: 'Go back', module: GoBack()),
  TutorialMenuButton(title: 'Scrolling', module: VerticalScrollSubmodule()),
  TutorialMenuButton(title: 'Explore menu', module: ExploreMenuPage()),
  TutorialMenuButton(title: 'Adjust slider', module: AdjustSlider()),
  // TutorialMenuButton(title: 'Practical application', module: null),
]);

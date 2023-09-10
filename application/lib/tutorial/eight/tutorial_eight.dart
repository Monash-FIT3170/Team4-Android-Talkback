import 'package:application/common/tutorial.dart';
import 'package:application/tutorial/eight/module/phone_module.dart';

TutorialMenu tutorialEight = TutorialMenu(title: 'Tutorial 8', moduleButtons: [
  const TutorialMenuButton(
      title: 'Phone challenge', module: PhonePad()),
  // TutorialMenuButton(title: 'Challenge', module: ChatView())
]);

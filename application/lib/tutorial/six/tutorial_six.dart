import 'package:application/common/tutorial.dart';
import 'package:application/tutorial/six/module/chat_view.dart';
import 'package:application/tutorial/six/module/type_with_virtual_keyboard.dart';

TutorialMenu tutorialSix = const TutorialMenu(title: 'Tutorial 6', moduleButtons: [
  TutorialMenuButton(
      title: 'Typing with a virtual keyboard', module: TypeWithKeyboard()),
  TutorialMenuButton(title: 'Challenge', module: ChatView())
]);

import 'package:application/common/tutorial.dart';
import 'package:application/tutorial/six/module/chat_view.dart';
import 'package:application/tutorial/six/module/type_with_virtual_keyboard.dart';
import 'package:easy_localization/easy_localization.dart';

TutorialMenu tutorialSix = TutorialMenu(title: 'Tutorial'.tr(args:['6']), moduleButtons: [
  TutorialMenuButton(title: 'tutorial6_lesson_title'.tr(), module: TypeWithKeyboard()),
  TutorialMenuButton(title: 'challenge'.tr(), module: ChatView())
]);

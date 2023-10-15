import 'package:application/common/tutorial.dart';
import 'package:application/tutorial/seven/module/calculator.dart';
import 'package:application/tutorial/seven/module/calculator_challenge.dart';

const TutorialMenu tutorialSeven =
    TutorialMenu(title: 'Tutorial 6', moduleButtons: [
  TutorialMenuButton(title: 'Calculator', module: CalculatorPage()),
  TutorialMenuButton(
      title: 'Calculator Challenge', module: CalculatorChallengePage()),
]);

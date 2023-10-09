import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CalculatorChallengePage extends StatefulWidget {
  const CalculatorChallengePage({super.key});

  @override
  State<CalculatorChallengePage> createState() =>
      _CalculatorChallengePageState();
}

class _CalculatorChallengePageState extends State<CalculatorChallengePage> {
  static const String _introText =
      "To complete this challenge, calculate the correct answer three times. Three incorrect answers will result in failure.";

  var userInput = '';
  var answer = '';
  var equationResult = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int totalEquations = -1;
  bool answeredCorrectly =
      false; // Flag to track if the user answered correctly

  static String _equation = "";

  @override
  void initState() {
    super.initState();
    _generateRandomEquation();
  }

  void _generateRandomEquation() {
    final Random random = Random();
    totalEquations += 1;

    final List<String> operators = ['+', '-', 'x', '/'];
    final List<String> operators_str = [
      'plus',
      'minus',
      'multiplied by',
      'divided by'
    ];
    String operator1 = operators[random.nextInt(operators.length)];
    String operator2 = operators[random.nextInt(operators.length)];

    while (operator2 == '/') {
      operator2 = operators[random.nextInt(operators.length)];
    }

    int operand1 = 1 + random.nextInt(99); // Random integer from 1 to 99
    int operand2 = 1;
    int operand3 = 1 + random.nextInt(30);

    if (operator1 == '/') {
      operand2 =
          1 + random.nextInt(99); // Random integer from 1 to 99 for the divisor
      operand1 =
          operand2 * (1 + random.nextInt(99)); // Ensure result is an integer
    } else {
      operand2 = 1 + random.nextInt(99); // Random integer from 1 to 99
    }

    int result = 0; // Initialize result with a default value

    // Ensure the result is always an integer
    if (operator2 == 'x' && operator1 != 'x' && operator1 != '/') {
      result = operand2 * operand3;
      if (operator1 == '+') {
        result = operand1 + result;
      } else if (operator1 == '-') {
        result = operand1 - result;
      }
    } else {
      if (operator1 == '+') {
        result = operand1 + operand2;
      } else if (operator1 == '-') {
        result = operand1 - operand2;
      } else if (operator1 == 'x') {
        result = operand1 * operand2;
      } else if (operator1 == '/') {
        // Avoid division by zero
        result = operand1 ~/ operand2;
      }

      // Ensure the result is always an integer
      if (operator2 == '+') {
        result = result + operand3;
      } else if (operator2 == '-') {
        result = result - operand3;
      } else if (operator2 == 'x') {
        result = result * operand3;
      } else if (operator2 == '/') {
        // Avoid division by zero
        result = result ~/ operand3;
      }
    }

    equationResult = result;

    // Convert to spoken
    operator1 = operators_str[operators.indexOf(operator1)];
    operator2 = operators_str[operators.indexOf(operator2)];

    _equation = "$operand1 $operator1 $operand2 $operator2 $operand3";
  }

  // Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: const Text("Calculator Challenge"),
      ), //AppBar
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(2),
              color: Colors.white, // Set the background color to white
              child: const Text(
                _introText,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(2),
              color: Colors.white, // Set the background color to white
              child: Text(
                "Equation: $_equation",
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(2),
              color: Colors.white, // Set the background color to white
              child: Text(
                "Correct Answers: $correctAnswers of $totalEquations",
              ),
            ),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }

                  // +/- button
                  else if (index == 1) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          // Check if userInput is not empty and the first character is "-"
                          if (userInput.isNotEmpty && userInput[0] == '-') {
                            // Remove the "-" sign if it's already negative
                            userInput = userInput.substring(1);
                          } else {
                            // Add a "-" sign if it's positive or empty
                            userInput = '-$userInput';
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }
                  // % Button
                  else if (index == 2) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }
                  // Delete Button
                  else if (index == 3) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }
                  // Equal_to Button
                  else if (index == 18) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orange[700],
                      textColor: Colors.white,
                    );
                  }
                  // Inside the MyButton widget for number buttons (0-9)
                  else if (index >= 4 && index <= 17) {
                    // Check if a number button is pressed
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          // Reset the answer to '0' when a new number is pressed after a calculation
                          if (calculationPerformed) {
                            answer = '0';
                            calculationPerformed = false; // Reset the flag
                          }
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }
                  //  other buttons
                  else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.blueAccent
                          : Colors.white,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  // Flag to track if a calculation has been performed
  bool calculationPerformed = false;

  // function to calculate the input operation
  void equalPressed() {
    String finalUserInput = userInput;

    // Check if userInput is empty
    if (finalUserInput.isEmpty) {
      return; // Do nothing if userInput is empty
    }

    finalUserInput = finalUserInput.replaceAll('x', '*');

    // Handle the '%' operation
    finalUserInput = finalUserInput.replaceAllMapped(RegExp(r'%+'), (match) {
      // Check for invalid syntax with multiple % symbols and replace with 'Syntax Error'
      if (match.group(0)!.length > 1) {
        // Add a null check with '?'
        return 'Syntax Error';
      } else {
        return '/100';
      }
    });

    Parser p = Parser();
    try {
      Expression exp = p.parse(finalUserInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();

      if (eval == equationResult) {
        answer += ' is correct';
      } else {
        answer += ' is incorrect';
      }

      // Check if the user's answer matches the equation result
      if (eval == equationResult) {
        // User answered correctly, generate a new equation
        _generateRandomEquation();
        answeredCorrectly = true; // Set the flag to true
        correctAnswers += 1;

        // Check if the user has passed the challenge
        if (correctAnswers == 3) {
          // Display a message and navigate back when the challenge is passed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Challenge Passed"),
                content:
                    const Text("You've successfully completed the challenge."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Go back a page
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        answeredCorrectly = false; // Set the flag to false
        incorrectAnswers += 1;

        // Check if the user has failed the challenge
        if (incorrectAnswers == 3) {
          // Display a message and navigate back when the challenge is failed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Challenge Failed"),
                content: const Text(
                    "You failed to calculate three correct answers."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Go back a page
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        } else {
          // Generate a new equation when the user answers incorrectly
          _generateRandomEquation();
        }
      }
    } catch (e) {
      answer = "Syntax Error";
      answeredCorrectly = false; // Set the flag to false
      incorrectAnswers += 1;

      // Check if the user has failed the challenge
      if (incorrectAnswers == 3) {
        // Display a message and navigate back when the challenge is failed
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Challenge Failed"),
              content: const Text("You've failed the challenge."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.pop(context); // Go back a page
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // Generate a new equation when the user answers incorrectly
        _generateRandomEquation();
      }
    }

    // Speak the result using FlutterTts
    if (!(correctAnswers == 3) && !(incorrectAnswers == 3)) {
      speakResult(answer);
    }

    setState(() {
      userInput = '';
      calculationPerformed = true;
    });
  }

  void speakResult(String text) async {
    FlutterTts flutterTts = FlutterTts();
    await Future.delayed(
        const Duration(seconds: 1)); // Introduce a pause of 1 second
    speakEquation(_equation);
    await flutterTts.speak(text);
  }

  void speakEquation(String text) async {
    FlutterTts flutterTts = FlutterTts();
    await Future.delayed(
        const Duration(seconds: 1)); // Introduce a pause of 1 second
    await flutterTts.speak(text);
  }
}

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
  // declaring variables
  // ignore: prefer_typing_uninitialized_variables
  final color;
  // ignore: prefer_typing_uninitialized_variables
  final textColor;
  final String buttonText;
  // ignore: prefer_typing_uninitialized_variables
  final buttontapped;

  //Constructor
  const MyButton(
      {super.key,
      this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

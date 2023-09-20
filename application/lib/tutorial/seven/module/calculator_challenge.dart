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
      "To complete this challenge, select three correct answers to the given equations to pass the challenge. Three incorrect answers will result in failure.";

  var userInput = '';
  var answer = '';
  var equationResult = 0;
  var correctAnswers = 0;

  static String _equation = "";

  @override
  void initState() {
    super.initState();
    _generateRandomEquation();
  }

  void _generateRandomEquation() {
    final Random random = Random();

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

    equationResult = result;

    // Convert to spoken
    operator1 = operators_str[operators.indexOf(operator1)];
    operator2 = operators_str[operators.indexOf(operator2)];

    _equation = "$operand1 $operator1 $operand2 $operator2 $operand3 = $result";
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
    String finaluserinput = userInput;

    // Check if userInput is empty
    if (finaluserinput.isEmpty) {
      return; // Do nothing if userInput is empty
    }

    finaluserinput = finaluserinput.replaceAll('x', '*');

    // Handle the '%' operation
    finaluserinput = finaluserinput.replaceAllMapped(RegExp(r'%+'), (match) {
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
      Expression exp = p.parse(finaluserinput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();
    } catch (e) {
      answer = "Syntax Error";
    }

    if (finaluserinput == '64+36' || finaluserinput == '36+64') {
      // Check if the input matches the specific equation
      Navigator.pop(context); // Close the current page
    } else {
      setState(() {
        userInput = '';
        calculationPerformed = true;
        // Speak the result using FlutterTts
        speakResult(answer);
      });
    }
  }

  void speakResult(String text) async {
    FlutterTts flutterTts = FlutterTts();
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

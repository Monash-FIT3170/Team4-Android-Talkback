import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  static const String _introText =
      "Welcome! In this module, you will learn how to use a calculator. Select each button by holding your finger on the screen and moving it over another button you'd like to select. To complete the lesson, calculator the result of \"64+36=\".";

    var userInput = '';
  var answer = '';
 
  // Array of button
  final List<String> buttons = [
    'C','+/-','%','DEL',
    '7', '8', '9', '/',
    '4', '5', '6', 'x',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back button
          title: const Text("Calculator Module"),
        ),  //AppBar
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Container(
            color: Colors.white, // Set the background color to white
            child: const Text(
          _introText,
              ),
            ),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Semantics(
                    label: answer, // Set the label to the answer text
                    child: Container(
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
                  )
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
                  else if (index >= 4 && index <= 17) { // Check if a number button is pressed
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
    finaluserinput = userInput.replaceAll('x', '*');

    // Handle the '%' operation
    finaluserinput = finaluserinput.replaceAllMapped(RegExp(r'%+'), (match) {
      // Check for invalid syntax with multiple % symbols and replace with 'Syntax Error'
      if (match.group(0)!.length > 1) { // Add a null check with '?'
        return 'Syntax Error';
      } else {
        return '/100*';
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
    }
    else {
        setState(() {
        // Update the UI, including the Semantics widget with the new answer
        userInput = '';
        calculationPerformed =  true;
    });
    }
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
  const MyButton({super.key, this.color, this.textColor, required this.buttonText, this.buttontapped});
 
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
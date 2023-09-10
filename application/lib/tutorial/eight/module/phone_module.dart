import 'package:flutter/material.dart';

class PhonePad extends StatefulWidget {
  const PhonePad({Key? key}) : super(key: key);
  @override
  _PhonePadState createState() => _PhonePadState();
}

class _PhonePadState extends State<PhonePad> {
  TextEditingController phoneNumberController = TextEditingController();
  String enteredNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Keyboard'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == 9) {
                  // This is the 'Call' button
                  return ElevatedButton(
                    onPressed: () {
                      _handleCall();
                    },
                    child: Text('Call'),
                  );
                } else if (index == 11) {
                  // This is the 'Backspace' button
                  return ElevatedButton(
                    onPressed: () {
                      _handleBackspace();
                    },
                    child: Icon(Icons.backspace),
                  );
                }  else if (index <= 8)  {
                  // These are the numeric buttons
                  List<String> keypad = [
                    '1', '2', '3',
                    '4', '5', '6',
                    '7', '8', '9',
                    '*', '0', '#',
                  ];
                  
                  return ElevatedButton(
                    onPressed: () {
                      _handleNumericInput(int.parse(keypad[index]));
                    },
                    child: Text(keypad[index]),
                  );
                }
              },
            ),
          ),
          Text('Entered Number: $enteredNumber'),
        ],
      ),
    );
  }

  void _handleNumericInput(int digit) {
    setState(() {
      enteredNumber += digit.toString();
    });
  }

  void _handleCall() {
    // Check if the entered number matches the expected number
    String expectedNumber = '1234567890'; // Replace with the expected number
    if (enteredNumber == expectedNumber) {
      // Call successful
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Call Successful'),
          content: Text('You have successfully called the number.'),
        ),
      );
    } else {
      // Call failed
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Call Failed'),
          content: Text('Please enter the correct phone number and try again.'),
        ),
      );
    }
  }

  void _handleBackspace() {
    setState(() {
      if (enteredNumber.isNotEmpty) {
        enteredNumber = enteredNumber.substring(0, enteredNumber.length - 1);
      }
    });
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }
}

void main() => runApp(MaterialApp(home: PhonePad()));

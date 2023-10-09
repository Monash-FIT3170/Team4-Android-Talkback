import 'package:application/routes.dart';
import 'package:flutter/material.dart';

class PhonePad extends StatefulWidget {
  const PhonePad({Key? key}) : super(key: key);
  @override
  PhonePadState createState() => PhonePadState();
}

class PhonePadState extends State<PhonePad> {
  final TextEditingController _phoneNumberController = TextEditingController();

  String _enteredNumber = '';

  @override
  Widget build(BuildContext context) {
    Widget empty = ElevatedButton(
      onPressed: () {},
      child: const Text(""),
    );

    Widget call = ElevatedButton(
      onPressed: () {
        _handleCall();
      },
      child: const Text('Call'),
    );
    Widget backspace = ElevatedButton(
      onPressed: () {
        _handleBackspace();
      },
      child: const Icon(Icons.backspace),
    );

    Widget asterisk = ElevatedButton(
      onPressed: () {},
      child: const Text("*"),
    );

    Widget hash = ElevatedButton(
      onPressed: () {},
      child: const Text("#"),
    );

    Widget key(int k) {
      return ElevatedButton(
        onPressed: () {
          _handleNumericInput(k);
        },
        child: Text(k.toString()),
      );
    }

    Widget placeholder = Container();
    // These are the numeric buttons
    final List<Widget> keypad = [
      [key(1), key(2), key(3)],
      [key(4), key(5), key(6)],
      [key(7), key(8), key(9)],
      [asterisk, key(0), hash],
      [placeholder, call, backspace]
    ].expand((x) => x).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Disable back button
        title: Focus(
          child: Semantics(
            focused: true, // Indicate that this widget is focused
            child: const Text(
              "Phone challenge",
              semanticsLabel:
                  "In this tutorial, you will learn how to call by typing phone number. Please enter 1234567890",
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Entered Number:\n $_enteredNumber',
              style: const TextStyle(fontSize: 30),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width -
                  50, // Set the maximum width of the GridView
              height: MediaQuery.of(context).size.height -
                  190, // Set the maximum height of the GridView
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) =>
                    index < keypad.length ? keypad[index] : null,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleNumericInput(int digit) {
    setState(() {
      _enteredNumber += digit.toString();
    });
  }

  void _handleCall() {
    // Check if the entered number matches the expected number
    String expectedNumber = '1234567890'; // Replace with the expected number
    if (_enteredNumber == expectedNumber) {
      // Call successful
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Challenge Passed"),
            content: const Text("You've successfully completed the challenge."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Routes.tutorialEight));
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // Call failed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Call Failed"),
            content: const Text(
                "Please enter the correct phone number and try again."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Pop this dialog so use can re-enter number
                  Navigator.pop(context);
                  // To reset phone number input
                  setState(() {
                    _enteredNumber = '';
                  });
                },
                child: const Text("Retry"),
              ),
            ],
          );
        },
      );
    }
  }

  void _handleBackspace() {
    setState(() {
      if (_enteredNumber.isNotEmpty) {
        _enteredNumber = _enteredNumber.substring(0, _enteredNumber.length - 1);
      }
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }
}

void main() => runApp(const MaterialApp(home: PhonePad()));

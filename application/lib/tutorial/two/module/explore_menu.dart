import 'package:flutter/material.dart';

class ExploreMenuPage extends StatefulWidget {
  const ExploreMenuPage({super.key});

  @override
  State<ExploreMenuPage> createState() => _ExploreMenuPageState();
}

class _ExploreMenuPageState extends State<ExploreMenuPage> {
  static const BorderSide _borderSideStyle =
      BorderSide(width: 2.0, color: Colors.black);
  static const String _introText =
      "Welcome! In this module, you will learn how to use explore by touch. You can select different elements by holding your finger on the screen and moving it over another element you'd like to select. To complete the lesson, use explore by touch to find the Finish Lesson button. Remember to drag your finger in any direction slowly around screen, and make sure your finger is touching the screen at all times. You may now start.";
  static const String _finishButtonText = 'Finish Lesson';

  // Define the list of button titles
  List<String> buttonTitles = [
    'Apple',
    'Ant',
    'January',
    'Banana',
    'Bee',
    'February',
    'Cherry',
    'Cricket',
    'March',
    'Elderberry',
    _finishButtonText,
    'May',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back button
          title: const Text("Explore Menu Module"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 5)),
              child: const Text(
                _introText,
              ),
            ),
            Expanded(
                child: GridView.count(
              // Create a grid with 3 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 3,
              // Generate widgets with button titles from the list in the desired order.
              children: buttonTitles.asMap().entries.map((entry) {
                final int index = entry.key;
                final String title = entry.value;

                // Check if it is the last row
                final isLastRow = (index >= buttonTitles.length - 3);

                // Check if it is the last row
                final isLastColumn = (index % 3 == 2);

                // Apply different border styles based on the row position
                final borderStyle = isLastRow && isLastColumn
                    ? const Border(
                        top: _borderSideStyle,
                        left: _borderSideStyle,
                        bottom: _borderSideStyle,
                        right: _borderSideStyle,
                      )
                    : isLastColumn
                        ? const Border(
                            top: _borderSideStyle,
                            left: _borderSideStyle,
                            right: _borderSideStyle,
                          )
                        : isLastRow
                            ? const Border(
                                top: _borderSideStyle,
                                left: _borderSideStyle,
                                bottom: _borderSideStyle,
                              )
                            : const Border(
                                top: _borderSideStyle,
                                left: _borderSideStyle,
                              );

                return Container(
                  decoration: BoxDecoration(
                    border: borderStyle,
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        if (title == _finishButtonText) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
          ],
        ));
  }
}

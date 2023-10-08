import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ExploreMenuPage extends StatefulWidget {
  const ExploreMenuPage({super.key});

  @override
  State<ExploreMenuPage> createState() => _ExploreMenuPageState();
}

class _ExploreMenuPageState extends State<ExploreMenuPage> {
  static const BorderSide _borderSideStyle =
      BorderSide(width: 2.0, color: Colors.black);
  static const String _introText = 'tutorial2_explore_menu_instr1';
  static const String _finishButtonText =
      'tutorial2_explore_menu_finish_lesson';

  // Define the list of button titles
  List<String> buttonTitles = [
    'tutorial2_explore_menu_apple',
    'tutorial2_explore_menu_ant',
    'tutorial2_explore_menu_january',
    'tutorial2_explore_menu_banana',
    'tutorial2_explore_menu_bee',
    'tutorial2_explore_menu_february',
    'tutorial2_explore_menu_cherry',
    'tutorial2_explore_menu_cricket',
    'tutorial2_explore_menu_march',
    'tutorial2_explore_menu_elderberry',
    _finishButtonText,
    'tutorial2_explore_menu_may'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back button
          title: const Text('tutorial2_explore_menu').tr(),
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
              ).tr(),
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
                        title.tr(),
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

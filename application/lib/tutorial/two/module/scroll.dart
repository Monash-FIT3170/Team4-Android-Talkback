// This lesson contains two submodules. Firstly the user must scroll *down* to
// reach a "Continue" button. Once pressed, they then must scroll "right" to
// reach a "Finish" button. Once pressed, the lesson ends.
//
// VerticalScrollSubmodule is the entry point to this lesson.
import 'package:application/common/instruction_card.dart';
import 'package:flutter/material.dart';

class VerticalScrollSubmodule extends _ScrollPage {
  @override
  Axis get axis => Axis.vertical;
  @override
  String get introInstruction =>
      "To scroll down, place two fingers on the screen at the same time, then swipe upwards with both of them. To scroll up, swipe with two fingers in the opposite direction. To finish, find the Continue button at the bottom of this vertical menu, then double tap it to continue.";
  // TODO: Consider having more descriptive semantic text so screenreader says something about moving on to next submodule, while button still just shows "Continue"
  @override
  String get successText => "Continue";

  const VerticalScrollSubmodule({super.key});

  @override
  onSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HorizontalScrollModule(prevContext: context)),
    );
  }
}

class HorizontalScrollModule extends _ScrollPage {
  @override
  Axis get axis => Axis.horizontal;
  @override
  String get introInstruction =>
      "To scroll right, swipe left with two fingers. To scroll left, swipe with two fingers in the opposite direction. To finish, tap the Finish button at the far right of this page.";
  @override
  String get successText => "Finish";

  final BuildContext prevContext;

  const HorizontalScrollModule({super.key, required this.prevContext});

  @override
  onSuccess(BuildContext context) {
    // Not pretty but it works, have to pop both this submodule and vertical submodule
    Navigator.pop(context);
    Navigator.pop(prevContext);
  }
}

abstract class _ScrollPage extends StatelessWidget {
  abstract final Axis axis;
  abstract final String introInstruction;
  abstract final String successText;
  final int _numButtons = 15;
  final double _globalPadding = 30;
  final double _itemPadding = 20;

  const _ScrollPage({super.key});

  onSuccess(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back button
          title: const Text("Scrolling Module"),
        ),
        body: Column(
          children: [
            InstructionsCard(instruction: introInstruction),
            Expanded(
                child: ListView.separated(
              scrollDirection: axis,
              padding: EdgeInsets.all(_globalPadding),
              itemCount: _numButtons,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100,
                  padding: axis == Axis.vertical
                      ? EdgeInsets.symmetric(vertical: _itemPadding)
                      : EdgeInsets.symmetric(horizontal: _itemPadding),
                  child: index == _numButtons - 1
                      ? ElevatedButton(
                          onPressed: () {
                            onSuccess(context);
                          },
                          child: Text(successText))
                      : ElevatedButton(
                          onPressed: null, child: Text('Item ${index + 1}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
          ],
        ));
  }
}

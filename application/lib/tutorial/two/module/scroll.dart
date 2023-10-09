// This lesson contains two submodules. Firstly the user must scroll *down* to
// reach a "Continue" button. Once pressed, they then must scroll "right" to
// reach a "Finish" button. Once pressed, the lesson ends.
//
// VerticalScrollSubmodule is the entry point to this lesson.
import 'package:application/common/instruction_card.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class VerticalScrollSubmodule extends _ScrollPage {
  @override
  Axis get axis => Axis.vertical;
  @override
  String get introInstruction => 'tutorial2_scrolling_instr1';
  // TODO: Consider having more descriptive semantic text so screenreader says something about moving on to next submodule, while button still just shows "Continue"
  @override
  String get successText => 'tutorial2_scrolling_continue';

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
  String get introInstruction => 'tutorial2_scrolling_instr2';
  @override
  String get successText => 'tutorial2_scrolling_finish';

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
          title: const Text('tutorial2_scrolling').tr(),
        ),
        body: Column(
          children: [
            InstructionsCard(instruction: introInstruction.tr()),
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
                          child: Text(successText).tr())
                      : ElevatedButton(
                          onPressed: null,
                          child: const Text('tutorial2_scrolling_item')
                              .tr(args: ['${index + 1}'])),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
          ],
        ));
  }
}

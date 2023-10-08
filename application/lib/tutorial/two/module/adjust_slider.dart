import 'dart:developer';

import 'package:application/common/instruction_card.dart';
import 'package:application/routes.dart';
import 'package:flutter/material.dart';

class AdjustSlider extends _AdjustSlider {
  const AdjustSlider({super.key})
      : super(
            desiredValue: 100,
            startValue: 0,
            instruction:
                "Welcome, in this module you'll learn how to  increase and decrease slider value. A slider is a track that contains values between a minimum and a maximum. Sliders are often used to adjust times. For example: song times or video times. You can also adjust this phone's volume using a slider. To start you will try and increase a slider's value. To increase the value, swipe up. To continue, increase the slider value to 100%",
            nextSubmodule: const AdjustSlider2());
}

class AdjustSlider2 extends _AdjustSlider {
  const AdjustSlider2({super.key})
      : super(
            desiredValue: 50,
            startValue: 100,
            instruction:
                "Now we will try and move the slider back down. To do this swipe down with one finger to reduce the value. Continue until the value is back to 50%",
            nextSubmodule: const AdjustSlider3());
}

class AdjustSlider3 extends _AdjustSlider {
  const AdjustSlider3({super.key})
      : super(
            desiredValue: 100,
            startValue: 50,
            instruction:
                "An alternative way of changing the volume is to double tap and hold the slider. From here you can swipe left and right to adjust it in that direction. Try and go back to 100%",
            nextSubmodule: null);
}

class _AdjustSlider extends StatefulWidget {
  final double desiredValue;
  final double startValue;
  final String instruction;
  final double _sliderFontSize = 30;
  final _AdjustSlider? nextSubmodule;

  const _AdjustSlider(
      {super.key,
      required this.desiredValue,
      required this.startValue,
      required this.instruction,
      required this.nextSubmodule});

  @override
  State<StatefulWidget> createState() {
    return _SliderSubmoduleState();
  }
}

class _SliderSubmoduleState extends State<_AdjustSlider> {
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.startValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Adjust slider'),
        ),
        body: Center(
            child: Column(children: [
          InstructionsCard(instruction: widget.instruction),
          // Round to zero decimal places to avoid floating point issues
          Text(_currentValue.toStringAsFixed(0),
              style: TextStyle(fontSize: widget._sliderFontSize)),
          Slider(
              value: _currentValue,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                  if (value.toInt() == widget.desiredValue.toInt()) {
                    log("Here?");
                    if (widget.nextSubmodule != null) {
                      log("Going to next submodule?");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            // Note '!' because nextSubmodule is nullable, see https://dart.dev/tools/non-promotion-reasons#property-or-this
                            builder: (context) => widget.nextSubmodule!),
                      );
                    } else {
                      log("Finished tutorial!");
                      Navigator.popUntil(
                          context, ModalRoute.withName(Routes.tutorialTwo));
                    }
                  }
                });
              },
              min: 0,
              divisions: 10,
              max: 100)
        ])));
  }
}

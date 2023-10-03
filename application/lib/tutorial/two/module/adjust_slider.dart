import 'package:application/common/instruction_card.dart';
import 'package:application/routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdjustSlider extends _AdjustSlider {
  const AdjustSlider({super.key})
      : super(
            desiredValue: 100,
            startValue: 0,
            instruction: 'tutorial2_adjust_slider_instr1',
            nextSubmodule: const AdjustSlider2());
}

class AdjustSlider2 extends _AdjustSlider {
  const AdjustSlider2({super.key})
      : super(
            desiredValue: 50,
            startValue: 100,
            instruction: 'tutorial2_adjust_slider_instr2',
            nextSubmodule: const AdjustSlider3());
}

class AdjustSlider3 extends _AdjustSlider {
  const AdjustSlider3({super.key})
      : super(
            desiredValue: 100,
            startValue: 50,
            instruction: 'tutorial2_adjust_slider_instr2',
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
          title: const Text('tutorial2_adjust_slider').tr(),
        ),
        body: Center(
            child: Column(children: [
          InstructionsCard(instruction: widget.instruction.tr()),
          // Round to zero decimal places to avoid floating point issues
          Text(_currentValue.toStringAsFixed(0),
              style: TextStyle(fontSize: widget._sliderFontSize)),
          Slider(
              value: _currentValue,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                  if (value.toInt() == widget.desiredValue.toInt()) {
                    if (widget.nextSubmodule != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            // Note '!' because nextSubmodule is nullable, see https://dart.dev/tools/non-promotion-reasons#property-or-this
                            builder: (context) => widget.nextSubmodule!),
                      );
                    } else {
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

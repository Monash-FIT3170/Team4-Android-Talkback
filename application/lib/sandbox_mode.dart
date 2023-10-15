import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SandBox extends StatefulWidget {
  const SandBox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GesturesState();
  }
}

class GesturesState extends State<SandBox> {
  int maxPointerCounter = 0;
  Timer? timer;
  void doubleTap() => {setState(() => gestureText = 'double_tap'.tr())};
  void longPress() => {setState(() => gestureText = 'long_press'.tr())};
  void handleSwipe(ScaleEndDetails details) => {
        maxPointerCounter = max(maxPointerCounter, details.pointerCount),
        if (maxPointerCounter == 0)
          if (details.velocity.pixelsPerSecond.dx.abs() >
              details.velocity.pixelsPerSecond.dy.abs())
            {setState(() => gestureText = 'horizontal_swipe'.tr())}
          else if (details.velocity.pixelsPerSecond.dx.abs() <=
              details.velocity.pixelsPerSecond.dy.abs())
            {
              setState(() =>
                  {gestureText = 'vertical_swipe'.tr(), details.pointerCount})
            },
        if (maxPointerCounter == 1)
          if (details.velocity.pixelsPerSecond.dx.abs() >
              details.velocity.pixelsPerSecond.dy.abs())
            {
              timer = Timer(const Duration(milliseconds: 100), () {
                setState(
                    () => gestureText = 'two_finger_horizontal_swipe'.tr());
                maxPointerCounter = 0;
              }),
            }
          else if (details.velocity.pixelsPerSecond.dx.abs() <=
              details.velocity.pixelsPerSecond.dy.abs())
            {
              timer = Timer(const Duration(milliseconds: 100), () {
                setState(() => gestureText = 'two_finger_vertical_swipe'.tr());
                maxPointerCounter = 0;
              }),
            },
        if (maxPointerCounter == 2)
          if (details.velocity.pixelsPerSecond.dx.abs() >
              details.velocity.pixelsPerSecond.dy.abs())
            {
              timer = Timer(const Duration(milliseconds: 100), () {
                setState(
                    () => gestureText = 'three_finger_horizontal_swipe'.tr());
                maxPointerCounter = 0;
              }),
            }
          else if (details.velocity.pixelsPerSecond.dx.abs() <=
              details.velocity.pixelsPerSecond.dy.abs())
            {
              timer = Timer(const Duration(milliseconds: 100), () {
                setState(
                    () => gestureText = 'three_finger_vertical_swipe'.tr());
                maxPointerCounter = 0;
              }),
            }
      };
  String gestureText = 'no_gestures_yet'.tr();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleEnd: handleSwipe,
      onDoubleTap: doubleTap,
      onLongPress: longPress,
      child: Scaffold(
          appBar: AppBar(title: const Text('sandbox').tr()),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('return_home').tr()),
                Text(gestureText)
              ]))),
    );
  }
}

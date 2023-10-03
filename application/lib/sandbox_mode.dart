import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

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
  void doubleTap() => {
        setState(() => {gestureText = "Double tap"})
      };
  void longPress() => {
        setState(() => {gestureText = "Long press"})
      };
  void handleSwipe(ScaleEndDetails details) => {
        maxPointerCounter = max(maxPointerCounter, details.pointerCount),
        if (maxPointerCounter == 0)
          if (details.velocity.pixelsPerSecond.dx.abs() >
              details.velocity.pixelsPerSecond.dy.abs())
            {
              setState(() => {gestureText = "Horizontal swipe"})
            }
          else if (details.velocity.pixelsPerSecond.dx.abs() <=
              details.velocity.pixelsPerSecond.dy.abs())
            {
              setState(
                  () => {gestureText = "Vertical swipe ", details.pointerCount})
            },
        if (maxPointerCounter == 1)
          if (details.velocity.pixelsPerSecond.dx.abs() >
              details.velocity.pixelsPerSecond.dy.abs())
            {
              timer = Timer(const Duration(milliseconds: 100), () {
                setState(() => {gestureText = "Two finger horizontal swipe"});
                maxPointerCounter = 0;
              }),
            }
          else if (details.velocity.pixelsPerSecond.dx.abs() <=
              details.velocity.pixelsPerSecond.dy.abs())
            {
              timer = Timer(const Duration(milliseconds: 100), () {
                setState(() => {gestureText = "Two finger vertical swipe"});
                maxPointerCounter = 0;
              }),
            },
        if (maxPointerCounter == 2)
          if (details.velocity.pixelsPerSecond.dx.abs() >
              details.velocity.pixelsPerSecond.dy.abs())
            {
              timer = Timer(const Duration(milliseconds: 100), () {
                setState(() => {gestureText = "Three finger horizontal swipe"});
                maxPointerCounter = 0;
              }),
            }
          else if (details.velocity.pixelsPerSecond.dx.abs() <=
              details.velocity.pixelsPerSecond.dy.abs())
            {
              timer = Timer(const Duration(milliseconds: 100), () {
                setState(() => {gestureText = "Three finger vertical swipe"});
                maxPointerCounter = 0;
              }),
            }
      };
  String gestureText = 'No gestures yet';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleEnd: handleSwipe,
      onDoubleTap: doubleTap,
      onLongPress: longPress,
      child: Scaffold(
          appBar: AppBar(title: const Text("SandBox")),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Return home")),
                Text(gestureText)
              ]))),
    );
  }
}

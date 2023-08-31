import 'package:flutter/material.dart';

/// A styled card to display instructions to a user.
class InstructionsCard extends StatelessWidget {
  final String instruction;
  final double _padding = 10;
  final double _boxWidth = 5;

  const InstructionsCard({super.key, required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(_padding),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: _boxWidth)),
      child: Text(
        instruction,
      ),
    );
  }
}

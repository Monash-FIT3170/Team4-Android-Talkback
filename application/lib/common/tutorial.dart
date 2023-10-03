/// Common widgets required for certain a Tutorial menu with Module buttons

import 'package:flutter/material.dart';

/// Represents the main menu for a Tutorial
class TutorialMenu extends StatelessWidget {
  /// Title to show at top of this tutorial's menu (e.g. "Tutorial 3")
  final String title;

  /// Buttons for each Module in this Tutorial
  final List<TutorialMenuButton> moduleButtons;

  const TutorialMenu(
      {required this.title, required this.moduleButtons, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: moduleButtons),
      ),
    );
  }
}

/// Represents a button in a Tutorial that takes the user to a Module
class TutorialMenuButton extends StatelessWidget {
  /// Which widget to navigate to when this button is clicked
  final Widget module;

  /// Title to show on this button (e.g. "Adjust slider")
  final String title;

  const TutorialMenuButton(
      {required this.title, required this.module, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => module),
        );
      },
      child: Text(title),
    );
  }
}

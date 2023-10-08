import 'package:application/tutorial/four/module/start_stop_media.dart';
import 'package:flutter/material.dart';
import 'package:application/tutorial/four/module/volume_media_control.dart';
import 'package:application/common/tutorial.dart';

const TutorialMenu tutorialFour =
    TutorialMenu(title: 'Tutorial 4', moduleButtons: [
  // TutorialMenuButton(title: 'Start and stop media', module: null),
  TutorialMenuButton(
      title: 'Media volume control', module: MediaVolumeControlPage()),
  // TutorialMenuButton(title: 'Challenge', module: null)
]);

import 'package:flutter/material.dart';
import 'package:application/tutorial/three/module/adjust_reading_controls.dart';

// import 'package:application/tutorial/three/module/jump_headers.dart';
// import 'package:application/tutorial/three/module/Jump_Headers_Part1_Fragment.dart';
//
// import 'package:application/tutorial/three/module/Jump_Controls_Part1_Fragment.dart';
// import 'package:application/tutorial/three/module/jump_controls.dart';
//
// import 'package:application/tutorial/three/module/Jump_Text_Part1_Fragment.dart';
// import 'package:application/tutorial/three/module/Jump_Text_Part2_Fragment.dart';
// import 'package:application/tutorial/three/module/jump_text.dart';
//
// import 'package:application/tutorial/three/module/adjust_reading_controls.dart';
//
import 'package:application/tutorial/three/module/jump_links.dart';
//
class TutorialThree extends StatelessWidget {
  const TutorialThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // scaffold page
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutorial Three"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const JumpHeaders()),
                //   );
              },
              child: const Text("Jump Headers Module"),
            ),
            ElevatedButton(
              onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const JumpControls()),
                //   );
              },
              child: const Text("Jump Controls Module"),
            ),
            ElevatedButton(
              onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const JumpText()),
                //   );
              },
              child: const Text("Jump Text Module"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdjustReadingControls()),
                );
              },
              child: const Text("Adjust Reading Controls Module"),
            ),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => const JumpLinks()),
                 );
              },
              child: const Text("Jump Links Module"),
            ),
          ],
        ),
      ),
    );
  }
}

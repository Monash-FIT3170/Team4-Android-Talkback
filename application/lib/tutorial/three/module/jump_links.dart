//import 'package:easy_localization/easy_localization.dart';
import 'package:application/common/instruction_card.dart';
import 'package:flutter/material.dart';


class JumpLinks extends StatelessWidget {
  final String introInstruction = "The Links reading control focuses the reading from one link to the next, including items such as email addresses, phone numbers, websites or addresses. To use the reading control to read the next link, swipe down and swipe up to read the previous link.";
  const JumpLinks({super.key});
  void navigateToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const JumpLinks2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jump Links")),
      body: Center(
        child: Column(
          children: <Widget>[
            InstructionsCard(instruction: introInstruction),
            const Text("The page will be filled with arbitrary text filled with 2 links that will allow you to skip the text to progress faster through the module."),
            InkWell(
              onTap: () {
              },
              child: const Text("www.link_1.com",
                style: TextStyle(
                  color: Colors.blue, // Customize link color
                  decoration: TextDecoration.underline, // Underline the link
                ),
              ),
            ),
            const Text("If you have not yet changed the reading controls to jump to links, complete the Adjust Reading Controls module to learn how to change the reading control being used."),
            InkWell(
              onTap: () {
              },
              child: const Text("www.link_2.com",
                style: TextStyle(
                  color: Colors.blue, // Customize link color
                  decoration: TextDecoration.underline, // Underline the link
                ),
              ),
            ),
            const Text("The links reading control allows you to skip text or other elements on a page, allowing you to navigate a page more efficiently. You are nearing the end of the first page of text and links."),
            InkWell(
              onTap: () {
                // Navigate to the next page (Page 2).
                navigateToNextPage(context);
              },
              child: const Text(
                "Continue to Page 2",
                style: TextStyle(
                  color: Colors.blue, // Customize link color
                  decoration: TextDecoration.underline, // Underline the link
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JumpLinks2 extends StatelessWidget {
  final String introInstruction = "The Links reading control focuses the reading from one link to the next, including items such as email addresses, phone numbers, websites or addresses. To use the reading control to read the next link, swipe down and swipe up to read the previous link.";

  const JumpLinks2({super.key});

  void finishModule(BuildContext context) {
    // Navigate back to the home screen.
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jump Links")),
      body: Center(
        child: Column(
          children: <Widget>[
            InstructionsCard(instruction: introInstruction),
            const Text("At this point hopefully you are familiar with the Links reading control and how exactly it works and what it allows you to do when navigating a page."),
            InkWell(
              onTap: () {
              },
              child: const Text("www.link_3.com",
                style: TextStyle(
                  color: Colors.blue, // Customize link color
                  decoration: TextDecoration.underline, // Underline the link
                ),
              ),
            ),
            const Text("This module shows how the Links reading control jumps from a link to the next, however remember it also works for emails, addresses and phone numbers."),
            InkWell(
              onTap: () {
              },
              child: const Text("www.link_4.com",
                style: TextStyle(
                  color: Colors.blue, // Customize link color
                  decoration: TextDecoration.underline, // Underline the link
                ),
              ),
            ),
            const Text("This concludes the end of the Jump Links module, explore other reading control methods to improve your experience with Talkback"),
            InkWell(
              onTap: () {
                finishModule(context);
              },
              child: const Text(
                "Finish Module",
                style: TextStyle(
                  color: Colors.blue, // Customize link color
                  decoration: TextDecoration.underline, // Underline the link
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

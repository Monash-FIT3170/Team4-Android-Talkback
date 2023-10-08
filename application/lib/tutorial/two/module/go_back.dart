import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class GoBack extends StatelessWidget {
  const GoBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: const Text('tutorial2_go_back').tr(),
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Focus(
                autofocus: true,
                child: const Text('tutorial2_go_back_instr1').tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

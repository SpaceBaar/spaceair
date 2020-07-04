import 'package:flutter/material.dart';
import 'package:space_air/app/strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(Strings.settings)],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:space_air/app/strings.dart';

class DirectionsPage extends StatelessWidget {
  const DirectionsPage();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text(Strings.findBestRoute)],
      );
}

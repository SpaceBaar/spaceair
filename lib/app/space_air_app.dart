import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_air/ui/home/home_page.dart';

import 'app_theme.dart';

class SpaceAirApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: HomePage(),
        theme: AppThemeDataFactory.prepareThemeData(),
      );
}

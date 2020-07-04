import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:space_air/app/app_icons.dart';
import 'package:space_air/app/strings.dart';
import 'package:space_air/data/api/pollution_rest_repository.dart';
import 'package:space_air/data/serialization/pollution_station.dart';
import 'package:space_air/domain/repository/pollution_repository.dart';
import 'package:space_air/ui/home/widgets/activities/activities_widget.dart';
import 'package:space_air/ui/home/widgets/activities/activity_widget.dart';
import 'package:space_air/ui/home/widgets/animated_percentage_widget.dart';
import 'package:space_air/ui/home/widgets/video_player_widget.dart';
import 'package:space_air/utils/api_exception_mapper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PollutionRepository _pollutionRepository = PollutionRestRepository();

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          VideoPlayerWidget(videoPath: "assets/videos/fog.mp4"),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTitle(),
                _buildExpandedContent(),
                _buildActivitiesWidget(),
              ],
            ),
          ),
        ],
      );

  Widget _buildTitle() => Text(
        Strings.exampleCityName,
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.center,
      );

  Widget _buildExpandedContent() => Expanded(
        child: Column(
          children: <Widget>[
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: FutureBuilder<PollutionStation>(
                  future: _pollutionRepository.getFirstStation(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                          ApiExceptionMapper.toErrorMessage(snapshot.error));
                    } else {
                      final station = snapshot.data;
                      return Text('${station.stationName}');
                    }
                  }),
            ),
            AnimatedPercentageWidget(
              fromValue: 0,
              toValue: 310,
            ),
            Text(Strings.airQualityNorm,
                style: Theme.of(context).textTheme.subtitle2),
            _buildDetailsWidget(),
          ],
        ),
      );

  Widget _buildDetailsWidget() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Opacity(opacity: 0.5, child: Text(Strings.details)),
            SizedBox(height: 5),
            Image.asset(AppIcons.arrowDown, width: 7, height: 7),
          ],
        ),
      );

  Widget _buildActivitiesWidget() => Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: ActivitiesWidget(
          activities: {
            ActivityType.walking: ActivityQuality.good,
            ActivityType.running: ActivityQuality.bad,
            ActivityType.biking: ActivityQuality.bad,
          },
        ),
      );
}

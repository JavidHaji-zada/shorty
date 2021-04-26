import 'package:flutter/material.dart';
import 'package:shorty/views/util/ViewConstants.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoadingIndicator extends StatelessWidget {
  final CustomConfig config;

  const LoadingIndicator({Key key, this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: WaveWidget(
        config: config == null
            ? CustomConfig(
                colors: [
                  ViewConstants.myBlue,
                  ViewConstants.myYellow,
                  ViewConstants.myPink,
                  ViewConstants.myWhite,
                ],
                durations: [
                  50000,
                  46000,
                  42000,
                  38000,
                ],
                heightPercentages: [0.60, 0.64, 0.68, 0.72],
              )
            : config,
        backgroundColor: Colors.transparent,
        size: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../shared/general/formatted_text.dart';
import '../../../../../stores/views/dashboard.dart';
import '../../../../../types/extensions/int.dart';
import 'stats_container.dart';

class Stats extends StatefulWidget {
  final EdgeInsets? pageIndicatorPadding;

  const Stats({Key? key, this.pageIndicatorPadding}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    DashboardStore dashboardStore = GetIt.instance<DashboardStore>();

    return Observer(builder: (_) {
      return Column(
        children: [
          Padding(
            padding: this.widget.pageIndicatorPadding ??
                const EdgeInsets.only(
                  top: 12.0,
                ),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: ScrollingDotsEffect(
                activeDotColor: Theme.of(context).toggleableActiveColor,
                dotHeight: 10.0,
                dotWidth: 10.0,
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: StatsContainer(
                    elevation: 0.0,
                    title: 'Performance',
                    children: [
                      FormattedText(
                        label: 'Total stream time',
                        text: dashboardStore.latestStreamStats?.totalStreamTime
                            .secondsToFormattedDurationString(),
                        width: 100.0,
                      ),
                      FormattedText(
                        label: 'FPS',
                        text: dashboardStore.latestStreamStats?.fps
                            .round()
                            .toString(),
                      ),
                      FormattedText(
                        label: 'kbit/s',
                        text: dashboardStore.latestStreamStats?.kbitsPerSec
                            .toString(),
                        width: 75.0,
                      ),
                      FormattedText(
                        label: 'CPU Usage',
                        unit: '%',
                        text: dashboardStore.latestStreamStats?.cpuUsage
                            .toStringAsFixed(2),
                        width: 70.0,
                      ),
                      FormattedText(
                        label: 'Memory Usage',
                        unit: ' GB',
                        text: dashboardStore.latestStreamStats?.memoryUsage !=
                                null
                            ? (dashboardStore.latestStreamStats!.memoryUsage /
                                    1000)
                                .toStringAsFixed(2)
                            : null,
                        width: 90.0,
                      ),
                      FormattedText(
                        label: 'Dropped Frames',
                        unit: '%',
                        text:
                            dashboardStore.latestStreamStats?.strain.toString(),
                        width: 95.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: StatsContainer(
                    elevation: 0.0,
                    title: 'Misc.',
                    children: [
                      FormattedText(
                        label: 'Missed Frames (render)',
                        text: dashboardStore
                            .latestStreamStats?.renderMissedFrames
                            .toStringAsFixed(2),
                        width: 135.0,
                      ),
                      FormattedText(
                        label: 'Skipped Frames (encoder)',
                        text: dashboardStore
                            .latestStreamStats?.outputSkippedFrames
                            .toString(),
                        width: 150.0,
                      ),
                      FormattedText(
                        label: 'Total Output Frames (encoder)',
                        text: dashboardStore
                            .latestStreamStats?.outputTotalFrames
                            .toString(),
                        width: 175.0,
                      ),
                      FormattedText(
                        label: 'Total Output Frames (render)',
                        text: dashboardStore
                            .latestStreamStats?.renderTotalFrames
                            .toString(),
                        width: 165.0,
                      ),
                      FormattedText(
                        label: 'Free Disk Space',
                        unit: ' GB',
                        text: dashboardStore.latestStreamStats?.freeDiskSpace !=
                                null
                            ? (dashboardStore.latestStreamStats!.freeDiskSpace
                                        .round() /
                                    1000)
                                .toString()
                            : null,
                        width: 165.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

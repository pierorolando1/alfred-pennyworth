import 'dart:math';

double calcFocus(DateTime wakeUpTime, int after) {
  return 50 + (50 * sin((2 * pi) / 90 * (after - 22.5)));
}

class ChartData {
  ChartData(this.xValue, this.lowValue, this.highValue, this.dataLabel);
  final num xValue;
  final double lowValue;
  final double highValue;
  final String dataLabel;
}

/// [ [min, max] ]
List<ChartData> generateFocusTimeline(DateTime wakeUpTime) {
  final now = DateTime.now();
  final end = DateTime(now.year, now.month, now.day, 20, 0, 0, 0, 0);
  final diff = end.difference(wakeUpTime);

  final List<ChartData> timeline = [];

  for (var i = 0; i < diff.inMinutes; i += 5) {
    final focusLevel = calcFocus(wakeUpTime, i);

    final num d = 6 * (1 + (i / diff.inMinutes));

    final addedTime = wakeUpTime.add(Duration(minutes: i));

    timeline.add(
      ChartData(
        i,
        max(0, focusLevel - d),
        min(100, focusLevel + d),
        "${ addedTime.hour }:${ addedTime.minute }",
      ),
    );
  }

  return timeline;
}

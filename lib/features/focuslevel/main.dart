import 'dart:math';

double calcFocus(int after) {
  return 50 + (50 * sin((2 * pi) / 90 * (after - 22.5)));
}

class ChartData {
  ChartData(this.xValue, this.yValue, this.lowValue, this.highValue, this.dataLabel);
  final num xValue;
  final num yValue;
  final double lowValue;
  final double highValue;
  final String dataLabel;
}

/// [ [min, max] ]
List<ChartData> generateFocusTimeline(DateTime wakeUpTime) {
  final now = DateTime.now();
  
  final end = DateTime(now.year, now.month, now.day, 21, 0, 0, 0, 0);
  final diff = end.difference(wakeUpTime);

  final List<ChartData> timeline = [];

  for (var i = 0; i < diff.inMinutes; i += 5) {
    final focusLevel = calcFocus(i);

    final num d = 6 * (1 + (i / diff.inMinutes));

    final addedTime = wakeUpTime.add(Duration(minutes: i));

    timeline.add(
      ChartData(
        i,
        focusLevel,
        max(0, focusLevel - d),
        min(100, focusLevel + d),
        "${ addedTime.hour }:${ addedTime.minute }",
      ),
    );
  }

  return timeline;
}

calcCurrFocus(DateTime wakeUpTime) {
  final now = DateTime.now();
  final diff = now.difference(wakeUpTime);

  int minutes = now.minute;

  if(minutes % 5 == 0) return [ChartData(diff.inMinutes, calcFocus(diff.inMinutes ), 0, 100, "${ now.hour }:${ now.minute }")];
  
  if(minutes > 55) {
    minutes = minutes - (minutes%5);
    return [ChartData(diff.inMinutes, calcFocus(diff.inMinutes), 0, 100, "${ now.hour }:$minutes")];
  }

  if(minutes%5 < ( 5 - (minutes%5))) {
      minutes = minutes - (minutes%5);
  } else {
      minutes = minutes + ( 5 - (minutes%5));
  }

  return [ChartData(diff.inMinutes, calcFocus(diff.inMinutes), 0, 100, "${ now.hour }:$minutes")];
}
import 'dart:async';

import 'package:alfred/features/focuslevel/domain/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FocusLevels extends StatefulWidget {
  final DateTime wakeUpTime;
  
  const FocusLevels({
    super.key,
    required this.wakeUpTime,
  });

  @override
  State<FocusLevels> createState() => _FocusLevelsState();
}

class _FocusLevelsState extends State<FocusLevels> {
  // calc with wakeUpTime Property
  List currTime = [];
  late Timer timer;

  @override
  void initState() {
    currTime = calcCurrFocus(widget.wakeUpTime);
    
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        currTime = calcCurrFocus(widget.wakeUpTime);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(17),
        child: Container(
          padding: const EdgeInsets.all(13),
          height: 290,
          width: 900,
          child: SfCartesianChart(
            zoomPanBehavior: ZoomPanBehavior(
              enableDoubleTapZooming: true,
              enablePinching: true,
              zoomMode: ZoomMode.x,
              enablePanning: true,
              enableMouseWheelZooming: true,
            ),
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              interval: 4,
              majorGridLines: const MajorGridLines(width: 0),
              labelPlacement: LabelPlacement.onTicks,
            ),
            primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 100,
              axisLine: const AxisLine(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelFormat: '{value}%',
              majorTickLines: const MajorTickLines(size: 0),
            ),
            series: [
              SplineSeries<ChartData, String>(
                color: const Color.fromRGBO(75, 135, 185, 0.5),
                dataSource: generateFocusTimeline(
                  widget.wakeUpTime,
                ),
                xValueMapper: (ChartData data, _) =>
                    data.dataLabel,
                yValueMapper: (datum, index) => datum.yValue,
              ),
              ScatterSeries<ChartData, String>(
                  dataSource: calcCurrFocus(widget.wakeUpTime),
                  opacity: 0.7,
                  xValueMapper: (ChartData data, _) =>
                      data.dataLabel,
                  yValueMapper: (ChartData data, _) =>
                      data.yValue,
                  markerSettings:
                      const MarkerSettings(height: 18, width: 18),
                  name: 'Now'),
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
          ),
        )
        );
  }
}
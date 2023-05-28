import 'package:alfred/features/auth/pages/loading_page.dart';
import 'package:alfred/features/auth/pages/login_page.dart';
import 'package:alfred/features/focuslevel/main.dart';
import 'package:alfred/shared/widgets/redirect.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final mainRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/alfred",
      builder: (context, state) => WillPopScope(
        onWillPop: () async {
          context.go("/app/home");
          return false;
        },
        child: const Scaffold(
          body: Center(
            child: Text("Alfred"),
          ),
        ),
      ),
    ),
    GoRoute(
        path: "/app",
        builder: (context, state) {
          return const Redirect();
        },
        routes: [
          ShellRoute(
            routes: [
              GoRoute(
                path: "home",
                builder: (context, state) => Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            axisLine: const AxisLine(width: 0),
                            labelPlacement: LabelPlacement.onTicks),
                        primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: 100,
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                        ),
                        zoomPanBehavior: ZoomPanBehavior(
                          enablePinching: true,
                          zoomMode: ZoomMode.x,
                          enablePanning: true,
                          enableMouseWheelZooming: true,
                        ),
                        series: <CartesianSeries<ChartData, String>>[
                          SplineRangeAreaSeries<ChartData, String>(
                            color: const Color.fromRGBO(75, 135, 185, 0.5),
                            borderColor: const Color.fromRGBO(75, 135, 185, 1),
                            borderWidth: 3,
                            dataSource: generateFocusTimeline(
                                DateTime(2023, 05, 27, 7, 0)),
                            xValueMapper: (ChartData data, _) => data.dataLabel as String,
                            lowValueMapper: (ChartData data, _) => data.lowValue,
                            highValueMapper: (ChartData data, _) => data.highValue,
                            dataLabelMapper: (ChartData data, _) => data.dataLabel,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GoRoute(
                path: "tasks",
                builder: (context, state) =>
                    const Scaffold(body: Center(child: Text("Tasks"))),
              ),
            ],
            builder: (context, state, child) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () => {context.go("/alfred")},
                  child: const Icon(Icons.mic_none_rounded),
                ),
                bottomNavigationBar: BottomAlfredBar(),
                body: child,
              );
            },
          ),
        ]),
    GoRoute(path: "/", builder: (context, state) => const LoadingPage()),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
  ],
);

class BottomAlfredBar extends StatefulWidget {
  const BottomAlfredBar({super.key});

  @override
  State<BottomAlfredBar> createState() => _BottomAlfredBarState();
}

class _BottomAlfredBarState extends State<BottomAlfredBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (e) => {
        setState(() {
          selectedIndex = e;
        }),
        if (e == 0)
          {context.go("/app/home")}
        else if (e == 1)
          {context.go("/app/tasks")}
        else if (e == 2)
          {context.go("/app/notes")}
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_rounded),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(Icons.task_alt_rounded),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(Icons.notes_rounded),
          label: '',
        )
      ],
    );
  }
}

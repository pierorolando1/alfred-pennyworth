import 'package:alfred/features/auth/pages/loading_page.dart';
import 'package:alfred/features/auth/pages/login_page.dart';
import 'package:alfred/features/tasks/pages/tasks_page.dart';
import 'package:alfred/pages/home_page.dart';
import 'package:alfred/shared/widgets/redirect.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                  path: "home", builder: (context, state) => const HomePage()),
              GoRoute(
                path: "tasks",
                builder: (context, state) => const TasksPage(),
              ),
            ],
            builder: (context, state, child) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () => {context.go("/alfred")},
                  child: const Icon(Icons.mic_none_rounded),
                ),
                bottomNavigationBar: MediaQuery.of(context).size.width < 640
                    ? const BottomAlfredBar()
                    : null,
                body: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (MediaQuery.of(context).size.width >= 640)
                      const AlfredRailNav(),
                    Expanded(child: child),
                  ],
                ),
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

class AlfredRailNav extends StatefulWidget {
  const AlfredRailNav({super.key});

  @override
  State<AlfredRailNav> createState() => _AlfredRailNavState();
}

class _AlfredRailNavState extends State<AlfredRailNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      minWidth: 85.0,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int e) {
        setState(() {
          _selectedIndex = e;
        });
        if (e == 0) {
          context.go("/app/home");
        } else if (e == 1) {
          context.go("/app/tasks");
        } else if (e == 2) {
          context.go("/app/notes");
        }
      },
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      groupAlignment: 0,
      labelType: NavigationRailLabelType.none,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_filled),
          label: Placeholder(),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.task_alt_rounded),
          label: Placeholder(),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.notes_rounded),
          label: Placeholder(),
        )
      ],
    );
  }
}

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
          icon: Icon(Icons.home_filled),
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

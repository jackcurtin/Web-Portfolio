import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/landingPage/resume/resume_pdf_view_page.dart';
import 'landingPage/landing_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: "Jack Curtin Porfolio");
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'cv',
          builder: (BuildContext context, GoRouterState state) {
            return const ResumePDFViewPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Jack Curtin Web Portfolio',
      theme: ThemeData(),
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const LandingPage(),
    );
  }
}

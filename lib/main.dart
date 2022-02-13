import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_line_chart/chart_information.dart';
import 'package:flutter_line_chart/progress_chart.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ChartInformation> _chartInformation =
      List<ChartInformation>.generate(
    10,
    (int index) => ChartInformation(
      value: Random().nextDouble() * 30,
      time: DateTime.now().add(Duration(days: index)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ProgressChart(chartInformation: _chartInformation),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_line_chart/chart_information.dart';
import 'package:flutter_line_chart/chart_painter.dart';

/// This class is used to display the chart information.
class ProgressChart extends StatefulWidget {
  const ProgressChart({required this.chartInformation, Key? key})
      : super(key: key);

  final List<ChartInformation> chartInformation;

  @override
  _ProgressChartState createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  late final List<double> _yAxisValues;
  late final List<DateTime> _xAxisValues;

  late final double _minValue;
  late final double _maxValue;

  @override
  void initState() {
    super.initState();

    _yAxisValues = _getYAxisValues(widget.chartInformation);
    _xAxisValues = _getXAxisValues(widget.chartInformation);

    _minValue = _getChartMinValue(widget.chartInformation);
    _maxValue = _getChartMaxValue(widget.chartInformation);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(),
      painter: ChartPainter(
        yAxisValues: _yAxisValues,
        xAxisValues: _xAxisValues,
        minValue: _minValue,
        maxValue: _maxValue,
      ),
    );
  }

  List<double> _getYAxisValues(List<ChartInformation> data) =>
      data.map((ChartInformation item) => item.value).toList();

  List<DateTime> _getXAxisValues(List<ChartInformation> data) =>
      data.map((ChartInformation item) => item.time).toList();

  double _getChartMinValue(List<ChartInformation> data) {
    double min = double.maxFinite;

    for (ChartInformation item in data) {
      min = min > item.value ? item.value : min;
    }

    return min;
  }

  double _getChartMaxValue(List<ChartInformation> data) {
    double max = double.minPositive;

    for (ChartInformation item in data) {
      max = max < item.value ? item.value : max;
    }

    return max;
  }
}

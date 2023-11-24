// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:movieapp/bar_graph/bar_data.dart';

class Linechart extends StatelessWidget {
  List<double> weekSummary = [
    80.40,
    20.50,
    22.42,
    30.50,
    90.20,
    88.99,
    91.10,
  ];

  Linechart({super.key});
  @override
  Widget build(BuildContext context) {
    BarData mybardata = BarData(
      sunAmount: weekSummary[0],
      monAmount: weekSummary[1],
      tueAmount: weekSummary[2],
      wedAmount: weekSummary[3],
      thuAmount: weekSummary[4],
      friAmount: weekSummary[5],
      satAmount: weekSummary[6],
    );
    mybardata.dataentry();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            child: AspectRatio(
              aspectRatio: 1,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(2.6, 2),
                        FlSpot(4.9, 5),
                        FlSpot(6.8, 2.5),
                        FlSpot(8, 4),
                        FlSpot(9.5, 3),
                        FlSpot(11, 4),
                      ],
                      color: Colors.black12,
                      isCurved: false,
                      dotData: const FlDotData(show: true),
                      barWidth: 5,
                    ),
                  ],
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(
                        color: Colors.deepPurple,
                        width: 2,
                      ),
                      left: BorderSide(
                        color: Colors.deepPurple,
                        width: 2,
                      ),
                    ),
                  ),
                  titlesData: const FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      axisNameWidget: Text('X axis'),
                      sideTitles: SideTitles(
                          showTitles: true, reservedSize: 30, interval: 3),
                    ),
                    leftTitles: AxisTitles(
                      axisNameWidget: Text('Y axis'),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                      ),
                    ),
                    topTitles: AxisTitles(
                      axisNameWidget: Text(''),
                    ),
                    rightTitles: AxisTitles(
                      axisNameWidget: Text(''),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bar_graph/bar_data.dart';

class Bargraph extends StatelessWidget {
  Bargraph({super.key});

  List<double> weekSummary = [
    80.40,
    20.50,
    42.42,
    10.50,
    90.20,
    88.99,
    95.10,
  ];

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
    return Column(
      children: [
        const SizedBox(
          height: 200,
        ),
        SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
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
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true, reservedSize: 40, interval: 20)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 20,
                  getTitlesWidget: getbottom,
                )),
              ),
              maxY: 100,
              minY: 0,
              barGroups: mybardata.bardata
                  .map((data) => BarChartGroupData(
                        x: data.x,
                        barRods: [
                          BarChartRodData(
                            toY: data.y,
                            color: const Color.fromARGB(255, 174, 74, 192),
                            width: 20,
                            borderRadius: BorderRadius.circular(4),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: 100,
                              color: Colors.grey[200],
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            'The Amount of money I spent on the weekends!!',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 65, 28, 129),
            ),
          ),
        )
      ],
    );
  }
}

Widget getbottom(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color.fromARGB(255, 174, 74, 192),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Sun', style: style);
      break;
    case 1:
      text = const Text('Mon', style: style);
      break;
    case 2:
      text = const Text('Tue', style: style);
      break;
    case 3:
      text = const Text('Wed', style: style);
      break;
    case 4:
      text = const Text('Thu', style: style);
      break;
    case 5:
      text = const Text('Fri', style: style);
      break;
    case 6:
      text = const Text('Sat', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

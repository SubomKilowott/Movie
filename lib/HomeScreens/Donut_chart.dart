// ignore_for_file: depend_on_referenced_packages

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bar_graph/bar_data.dart';

class Donutchart extends StatefulWidget {
  const Donutchart({Key? key}) : super(key: key);

  @override
  State<Donutchart> createState() => _DonutchartState();
}

class _DonutchartState extends State<Donutchart> {
  List<double> weekSummary = [
    80.40,
    20.50,
    22.42,
    30.50,
    90.20,
    88.99,
    91.10,
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

    double average = calculateAverage();

    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Colors.blue,
                    ),
                    Text('Sunday')
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Color.fromARGB(255, 33, 243, 191),
                    ),
                    Text('Monday')
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Color.fromARGB(255, 117, 33, 243),
                    ),
                    Text('Tuesday')
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Color.fromARGB(255, 201, 243, 33),
                    ),
                    Text('Wednesday')
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Color.fromARGB(255, 243, 33, 191),
                    ),
                    Text('Thursday')
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Color.fromARGB(255, 243, 100, 33),
                    ),
                    Text('Friday')
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Color.fromARGB(255, 243, 33, 68),
                    ),
                    Text('Satruday')
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 280,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: mybardata.sunAmount,
                        color: Colors.blue,
                      ),
                      PieChartSectionData(
                        value: mybardata.monAmount,
                        color: const Color.fromARGB(255, 33, 243, 191),
                      ),
                      PieChartSectionData(
                        value: mybardata.tueAmount,
                        color: const Color.fromARGB(255, 117, 33, 243),
                      ),
                      PieChartSectionData(
                        value: mybardata.wedAmount,
                        color: const Color.fromARGB(255, 201, 243, 33),
                      ),
                      PieChartSectionData(
                        value: mybardata.thuAmount,
                        color: const Color.fromARGB(255, 243, 33, 191),
                      ),
                      PieChartSectionData(
                        value: mybardata.friAmount,
                        color: const Color.fromARGB(255, 243, 100, 33),
                      ),
                      PieChartSectionData(
                        value: mybardata.satAmount,
                        color: const Color.fromARGB(255, 243, 33, 68),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Average: ${average.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
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
      ),
    );
  }

  double calculateAverage() {
    double sum = weekSummary.reduce((value, element) => value + element);
    return sum / weekSummary.length;
  }
}

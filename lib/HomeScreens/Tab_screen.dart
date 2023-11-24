// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:movieapp/HomeScreens/Bar_chart.dart';
import 'package:movieapp/HomeScreens/Donut_chart.dart';
import 'package:movieapp/HomeScreens/line_chart.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: const TabBar(indicatorSize: TabBarIndicatorSize.label, tabs: [
            Tab(
              icon: Icon(Icons.donut_large_outlined),
            ),
            Tab(
              icon: Icon(Icons.bar_chart),
            ),
            Tab(
              icon: Icon(Icons.auto_graph_rounded),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            const Center(
              child: Donutchart(),
            ),
            Center(
              child: Bargraph(),
            ),
            Center(
              child: Linechart(),
            ),
          ],
        ),
      ),
    );
  }
}

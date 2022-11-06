import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget chart() {
 return Center(
   child:SfCircularChart(
   title: ChartTitle(text: 'Budget Status'),
   legend: Legend(isVisible: true),
   series: <PieSeries<_PieData, String>>[
     PieSeries<_PieData, String>(
       explode: true,
       explodeIndex: 0,
       dataSource: pieData,
       xValueMapper: (_PieData data, _) => data.xData,
       yValueMapper: (_PieData data, _) => data.yData,
       dataLabelMapper: (_PieData data, _) => data.text,
       dataLabelSettings: DataLabelSettings(isVisible: true)),
   ]
  )
 );
}

class _PieData {
 _PieData(this.xData, this.yData, this.text);
 final String xData;
 final num yData;
 final String text;
}

List<_PieData> pieData = [
  _PieData("Spent", 30, "Rs.15000"),
  _PieData("Balance", 70, "Rs.30000"),
];
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

    Widget barChart () {
        final List<SalesData> chartData = [
            SalesData(DateTime(2010), 35, 30),
            SalesData(DateTime(2011), 28, 20),
            SalesData(DateTime(2012), 34, 40),
            SalesData(DateTime(2013), 32, 20),
            SalesData(DateTime(2014), 40, 40)
        ];

        return Center(
                    child: SfCartesianChart(
                        title: ChartTitle(text: 'Monthly Cashflow Change'),
                        legend: Legend(isVisible: true),
                        primaryXAxis: DateTimeAxis(),
                        series: <ChartSeries>[
                            // Renders line chart
                            LineSeries<SalesData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales1,
                                xAxisName: 'Time',
                                yAxisName: 'Amount (Rs.)',
                                name: 'Income',
                            ),
                            LineSeries<SalesData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales2,
                                xAxisName: 'Time',
                                yAxisName: 'Amount (Rs.)',
                                name: 'Expense',
                            )
                        ]
                    )
        );
    }

    class SalesData {
        SalesData(this.year, this.sales1, this.sales2);
        final DateTime year;
        final double sales1;
        final double sales2;
    }
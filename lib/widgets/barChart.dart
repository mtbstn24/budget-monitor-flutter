import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

    Widget barChart () {
        final List<EntryData> chartData = [
            EntryData(DateTime(2022,07), 35000, 30000),
            EntryData(DateTime(2022,08), 28000, 20000),
            EntryData(DateTime(2022,09), 34000, 40000),
            EntryData(DateTime(2022,10), 32000, 20000),
            EntryData(DateTime(2022,11), 40000, 40000)
        ];

        return Center(
                    child: SfCartesianChart(
                        title: ChartTitle(text: 'Monthly Cashflow Change'),
                        legend: Legend(isVisible: true),
                        primaryXAxis: DateTimeAxis(),
                        series: <ChartSeries>[
                            // Renders line chart
                            LineSeries<EntryData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (EntryData entry, _) => entry.year,
                                yValueMapper: (EntryData entry, _) => entry.entry1,
                                xAxisName: 'Time',
                                yAxisName: 'Amount (Rs.)',
                                name: 'Income',
                            ),
                            LineSeries<EntryData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (EntryData entry, _) => entry.year,
                                yValueMapper: (EntryData entry, _) => entry.entry2,
                                xAxisName: 'Time',
                                yAxisName: 'Amount (Rs.)',
                                name: 'Expense',
                            )
                        ]
                    )
        );
    }

    class EntryData {
        EntryData(this.year, this.entry1, this.entry2);
        final DateTime year;
        final double entry1;
        final double entry2;
    }
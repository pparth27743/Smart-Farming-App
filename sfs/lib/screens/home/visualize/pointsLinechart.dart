import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PointsLineChart extends StatelessWidget {
  ///
  final String title;
  final String yParameter;
  final xValues;
  final List<DateTime> yValues;
  final int countDataPoint;
  //
  List<charts.Series<DataPoint, DateTime>> seriesList;

  PointsLineChart(
      {this.title,
      this.yParameter,
      this.xValues,
      this.yValues,
      this.countDataPoint}) {
    seriesList = _createSampleData();
  }

  List<charts.Series<DataPoint, DateTime>> _createSampleData() {
    var dataPoint = List<DataPoint>();

    for (int i = 0; i < countDataPoint; i++) {
      dataPoint.add(new DataPoint(yValues[i], xValues[i]));
    }

    return [
      new charts.Series<DataPoint, DateTime>(
          id: title,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (DataPoint dataPoint, _) => dataPoint.xVal,
          measureFn: (DataPoint dataPoint, _) => dataPoint.yVal,
          data: dataPoint)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                      Expanded(
                        child: charts.TimeSeriesChart(seriesList,
                            animate: true,
                            animationDuration: Duration(seconds: 3),
                            dateTimeFactory:
                                const charts.LocalDateTimeFactory(),
                            domainAxis: charts.DateTimeAxisSpec(
                              tickFormatterSpec:
                                  charts.AutoDateTimeTickFormatterSpec(
                                minute: new charts.TimeFormatterSpec(
                                  format: 'mm', // or even HH:mm here too
                                  transitionFormat: 'HH:mm',
                                ),
                              ),
                            ),
                            defaultRenderer: new charts.LineRendererConfig(
                                includePoints: true,
                                includeArea: true,
                                stacked: true),
                            behaviors: [
                              new charts.ChartTitle('Time',
                                  behaviorPosition:
                                      charts.BehaviorPosition.bottom,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                              new charts.ChartTitle(yParameter,
                                  behaviorPosition:
                                      charts.BehaviorPosition.start,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sample linear data type.
class DataPoint {
  final DateTime xVal;
  final int yVal;

  DataPoint(this.xVal, this.yVal);
}

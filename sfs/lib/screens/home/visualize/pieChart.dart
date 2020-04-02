import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChart extends StatelessWidget {
  //
  final String title;
  final Map<String, int> dict;

  List<charts.Series<_Data, String>> seriesPieData;

  PieChart({this.title, this.dict}) {
    seriesPieData = _createSampleData();
  }

  List<charts.Series<_Data, String>> _createSampleData() {
    int total = dict['On'] + dict['Off'];

    var piedata = [
      new _Data('On', dict['On'], (dict['On'].toDouble() / total) * 100, Colors.blue),
      new _Data('Off', dict['Off'], (dict['Off'].toDouble() / total) * 100,Colors.blueGrey),
    ];

    return [
      new charts.Series<_Data, String>(
        id: title,
        domainFn: (_Data data, _) => data.name,
        measureFn: (_Data data, _) => data.percentage,
        colorFn: (_Data data, _) =>
            charts.ColorUtil.fromDartColor(data.colorval),
        data: piedata,
        labelAccessorFn: (_Data row, _) =>
            '${row.percentage.toStringAsFixed(2)} % \n ${row.val} times',
      ),
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
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: charts.PieChart(seriesPieData,
                            animate: true,
                            animationDuration: Duration(seconds: 3),
                            behaviors: [
                              new charts.DatumLegend(
                                outsideJustification:
                                    charts.OutsideJustification.endDrawArea,
                                horizontalFirst: false,
                                desiredMaxRows: 2,
                                cellPadding: new EdgeInsets.only(
                                    right: 4.0, bottom: 4.0),
                                entryTextStyle: charts.TextStyleSpec(
                                    color: charts
                                        .MaterialPalette.purple.shadeDefault,
                                    fontFamily: 'Georgia',
                                    fontSize: 11),
                              )
                            ],
                            defaultRenderer: new charts.ArcRendererConfig(
                                arcWidth: 100,
                                arcRendererDecorators: [
                                  new charts.ArcLabelDecorator(
                                      labelPosition:
                                          charts.ArcLabelPosition.inside)
                                ])),
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

class _Data {
  String name;
  double percentage;
  int val;
  Color colorval;

  _Data(this.name, this.val, this.percentage, this.colorval);
}

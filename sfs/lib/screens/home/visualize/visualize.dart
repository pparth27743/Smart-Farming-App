import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sfs/models/farm.dart';
import 'package:sfs/models/user.dart';
import 'package:sfs/screens/home/visualize/pieChart.dart';
import 'package:sfs/screens/home/visualize/pointsLinechart.dart';
import 'package:sfs/services/authService.dart';
import 'package:sfs/services/database.dart';
import 'package:sfs/shared/loading.dart';

class Visualize extends StatelessWidget {
  //
  final String visualizeDataOf;
  final AuthService _auth = AuthService();

  Visualize(this.visualizeDataOf);

  @override
  Widget build(BuildContext context) {
    //
    User user = Provider.of<User>(context);
    //
    return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: RichText(
              text: TextSpan(
                  text: 'SFS',
                  style: GoogleFonts.lobster(
                      fontSize: 40, color: Colors.brown[500]))),
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: Text(
                'Sign Out',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: StreamBuilder<User>(
            stream: DatabaseService(farmerid: user.farmerId).userData,
            builder: (farmercontext, farmersnapshot) {
              if (farmersnapshot.hasData) {
                user = farmersnapshot.data;

                return StreamBuilder<List<Farm>>(
                    stream:
                        DatabaseService(farmerid: user.farmerId).allFarmData,
                    builder: (farmcontext, farmsnapshot) {
                      if (farmsnapshot.hasData) {
                        user.farmlst = farmsnapshot.data;

                        int countDataPoint = user.farmlst.length;
                        List<int> lstTemp = new List<int>();
                        List<int> lstHumidity = new List<int>();
                        List<int> lstSoilMoisture = new List<int>();
                        List<int> lstPump = new List<int>();
                        List<int> lstRooftop = new List<int>();
                        List<DateTime> lstTime = new List<DateTime>();

                        for (int i = 0; i < 20; i++) {
                          lstTemp.add(user.farmlst[i].temp);
                          lstHumidity.add(user.farmlst[i].humidity);
                          lstSoilMoisture.add(user.farmlst[i].soilMoisture);
                          lstPump.add(user.farmlst[i].pump ? 1 : 0);
                          lstRooftop.add(user.farmlst[i].rooftop ? 1 : 0);
                          lstTime.add(user.farmlst[i].timestamp.toDate());
                        }

                        Map<String, int> pumpDict = {'On': 0, 'Off': 0};
                        Map<String, int> rooftopDict = {'On': 0, 'Off': 0};

                        for (int i = 0; i < 20; i++) {
                          if (lstPump[i] == 1)
                            pumpDict.update(
                                'On', (dynamic val) => pumpDict['On'] + 1);
                          else
                            pumpDict.update(
                                'Off', (dynamic val) => pumpDict['Off'] + 1);

                          if (lstRooftop[i] == 1)
                            rooftopDict.update(
                                'On', (dynamic val) => rooftopDict['On'] + 1);
                          else
                            rooftopDict.update(
                                'Off', (dynamic val) => rooftopDict['Off'] + 1);
                        }

                        switch (visualizeDataOf) {
                          case "temperature":
                            return PointsLineChart(
                              title: 'Last 20 Temperature Values',
                              yParameter: 'Temperature °C',
                              xValues: lstTemp,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'humidity':
                            return PointsLineChart(
                              title: 'Last 20 Humidity Values',
                              yParameter: 'Humidity %',
                              xValues: lstHumidity,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'soilMoisture':
                            return PointsLineChart(
                              title: 'Last 20 Soil Moisture Values',
                              yParameter: 'Soil Moisture %',
                              xValues: lstSoilMoisture,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'pump':
                            return PointsLineChart(
                              title: 'Last 20 Pump Values',
                              yParameter: 'Pump',
                              xValues: lstPump,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'pump_pie':
                            return PieChart(
                              title: 'Last 20 Pump Values',
                              dict: pumpDict,
                            );
                            break;

                          case 'rooftop':
                            return PointsLineChart(
                              title: 'Last 20 Rooftop Values',
                              yParameter: 'Rooftop',
                              xValues: lstRooftop,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'rooftop_pie':
                            return PieChart(
                              title: 'Last 20 Rooftop Values',
                              dict: rooftopDict,
                            );
                            break;

                          default:
                            return Center(
                              child: Text(
                                "Not found",
                                style: TextStyle(
                                    fontSize: 80,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                            break;
                        }
                      } else {
                        return Loading();
                      }
                    });
              } else {
                return Loading();
              }
            }));
  }
}

// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class Prediction extends StatefulWidget {
//   final Widget child;

//   Prediction({Key key, this.child}) : super(key: key);

//   _PredictionState createState() => _PredictionState();
// }

// class _PredictionState extends State<Prediction> {

//   List<charts.Series<Task, String>> _seriesPieData;

//   _generateData() {

//     var piedata = [
//       new Task('On', 35.8, Colors.blue),
//       new Task('Off', 8.3, Colors.blueGrey),
//     ];

//     _seriesPieData.add(
//       charts.Series(
//         domainFn: (Task task, _) => task.task,
//         measureFn: (Task task, _) => task.taskvalue,
//         colorFn: (Task task, _) =>
//             charts.ColorUtil.fromDartColor(task.colorval),
//         id: 'Air Pollution',
//         data: piedata,
//          labelAccessorFn: (Task row, _) => '${row.taskvalue}',
//       ),
//     );

//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _seriesPieData = List<charts.Series<Task, String>>();
//     _generateData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 1,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Color(0xff1976d2),
//             //backgroundColor: Color(0xff308e1c),
//             bottom: TabBar(
//               indicatorColor: Color(0xff9962D0),
//               tabs: [

//                 Tab(icon: Icon(FontAwesomeIcons.chartPie)),

//               ],
//             ),
//             title: Text('Flutter Charts'),
//           ),
//           body: TabBarView(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Container(
//                   child: Center(
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                             'Time spent on daily tasks',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
//                             SizedBox(height: 10.0,),
//                         Expanded(
//                           child: charts.PieChart(
//                             _seriesPieData,
//                             animate: true,
//                             animationDuration: Duration(seconds: 5),
//                              behaviors: [
//                             new charts.DatumLegend(
//                               outsideJustification: charts.OutsideJustification.endDrawArea,
//                               horizontalFirst: false,
//                               desiredMaxRows: 2,
//                               cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
//                               entryTextStyle: charts.TextStyleSpec(
//                                   color: charts.MaterialPalette.purple.shadeDefault,
//                                   fontFamily: 'Georgia',
//                                   fontSize: 11),
//                             )
//                           ],
//                            defaultRenderer: new charts.ArcRendererConfig(
//                               arcWidth: 100,
//                              arcRendererDecorators: [
//           new charts.ArcLabelDecorator(
//               labelPosition: charts.ArcLabelPosition.inside)
//         ])),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Task {
//   String task;
//   double taskvalue;
//   Color colorval;

//   Task(this.task, this.taskvalue, this.colorval);
// }

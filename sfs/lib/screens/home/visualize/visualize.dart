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
  int countDataPoint;
  final AuthService _auth = AuthService();

  Visualize({this.visualizeDataOf, this.countDataPoint});

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

                        int totalLength = user.farmlst.length;
                        if(totalLength <= countDataPoint){
                          countDataPoint = totalLength;
                        }
                        List<int> lstTemp = new List<int>();
                        List<int> lstHumidity = new List<int>();
                        List<int> lstSoilMoisture = new List<int>();
                        List<int> lstPump = new List<int>();
                        List<int> lstRooftop = new List<int>();
                        List<DateTime> lstTime = new List<DateTime>();



                        for (int i = 0; i < countDataPoint; i++) {
                          lstTemp.add(user.farmlst[i].temp);
                          lstHumidity.add(user.farmlst[i].humidity);
                          lstSoilMoisture.add(user.farmlst[i].soilMoisture);
                          lstPump.add(user.farmlst[i].pump ? 1 : 0);
                          lstRooftop.add(user.farmlst[i].rooftop ? 1 : 0);
                          lstTime.add(user.farmlst[i].timestamp.toDate());
                        }

                        Map<String, int> pumpDict = {'On': 0, 'Off': 0};
                        Map<String, int> rooftopDict = {'On': 0, 'Off': 0};

                        for (int i = 0; i < countDataPoint; i++) {
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
                              title: 'Last ${countDataPoint} Temperature Values',
                              yParameter: 'Temperature °C',
                              xValues: lstTemp,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'humidity':
                            return PointsLineChart(
                              title: 'Last ${countDataPoint} Humidity Values',
                              yParameter: 'Humidity %',
                              xValues: lstHumidity,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'soilMoisture':
                            return PointsLineChart(
                              title: 'Last ${countDataPoint} Soil Moisture Values',
                              yParameter: 'Soil Moisture %',
                              xValues: lstSoilMoisture,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'pump':
                            return PointsLineChart(
                              title: 'Last ${countDataPoint} Pump Values',
                              yParameter: 'Pump',
                              xValues: lstPump,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'pump_pie':
                            return PieChart(
                              title: 'Last ${countDataPoint} Pump Values',
                              dict: pumpDict,
                            );
                            break;

                          case 'rooftop':
                            return PointsLineChart(
                              title: 'Last ${countDataPoint} Rooftop Values',
                              yParameter: 'Rooftop',
                              xValues: lstRooftop,
                              yValues: lstTime,
                              countDataPoint: countDataPoint,
                            );
                            break;

                          case 'rooftop_pie':
                            return PieChart(
                              title: 'Last ${countDataPoint} Rooftop Values',
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



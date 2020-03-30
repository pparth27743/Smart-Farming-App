import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfs/models/farm.dart';
import 'package:sfs/models/user.dart';
import 'package:sfs/screens/home/visualize/pointsLinechart.dart';
import 'package:sfs/services/database.dart';
import 'package:sfs/shared/loading.dart';


class Visualize extends StatelessWidget {
  //
  final String sensorData;

  Visualize(this.sensorData);

  @override
  Widget build(BuildContext context) {
    //
    User user = Provider.of<User>(context);
    //
    return StreamBuilder<User>(
        stream: DatabaseService(farmerid: user.farmerId).userData,
        builder: (farmercontext, farmersnapshot) {
          if (farmersnapshot.hasData) {
            user = farmersnapshot.data;

            return StreamBuilder<List<Farm>>(
                stream: DatabaseService(farmerid: user.farmerId).allFarmData,
                builder: (farmcontext, farmsnapshot) {
                  if (farmsnapshot.hasData) {
                    user.farmlst = farmsnapshot.data;

                    int countDataPoint = user.farmlst.length;
                    List<int> lstTemp = new List<int>();
                    List<int> lstHumidity = new List<int>();
                    List<int> lstSoilMoisture = new List<int>();
                    List<bool> lstPump = new List<bool>();
                    List<bool> lstRooftop = new List<bool>();
                    List<DateTime> lstTime = new List<DateTime>();

                    for (int i = 0; i < 20; i++) {
                      lstTemp.add(user.farmlst[i].temp);
                      lstHumidity.add(user.farmlst[i].humidity);
                      lstSoilMoisture.add(user.farmlst[i].soilMoisture);
                      lstPump.add(user.farmlst[i].pump);
                      lstRooftop.add(user.farmlst[i].rooftop);
                      lstTime.add(user.farmlst[i].timestamp.toDate());
                    }

                    switch (sensorData) {
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

                      case 'rooftop':
                        return PointsLineChart(
                          title: 'Last 20 Rooftop Values',
                          yParameter: 'Rooftop',
                          xValues: lstRooftop,
                          yValues: lstTime,
                          countDataPoint: countDataPoint,
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
        });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sfs/models/farm.dart';
import 'package:sfs/models/user.dart';
import 'package:sfs/screens/home/visualize/visualize.dart';
import 'package:sfs/services/authService.dart';
import 'package:sfs/services/database.dart';
import 'package:sfs/shared/loading.dart';



final int countDataPoint = 20;

class SensorData extends StatefulWidget {
 
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  Future navigateToSubPage(context, String visualizeDataOf) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return StreamProvider<User>.value(
          value: AuthService().user,
          child: Visualize(visualizeDataOf:visualizeDataOf, countDataPoint: countDataPoint),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    //
    User user = Provider.of<User>(context);
    return StreamBuilder<User>(
        stream: DatabaseService(farmerid: user.farmerId).userData,
        builder: (farmercontext, farmersnapshot) {
          if (farmersnapshot.hasData) {
            user = farmersnapshot.data;

            if (user.isFramAvailable) {
              return StreamBuilder<List<Farm>>(
                  stream:
                      DatabaseService(farmerid: user.farmerId).latestFarmData,
                  builder: (farmcontext, farmsnapshot) {
                    if (farmsnapshot.hasData) {
                      user.farmlst = farmsnapshot.data;
                      Farm farm = user.farmlst[0];

                      String pump = farm.pump ? 'On' : 'Off';
                      String rooftop = farm.rooftop ? 'On' : 'Off';
                      String updatedTime =
                          DateFormat('hh:mm:ss aaa EEEE, d MMM, yyyy')
                              .format(farm.timestamp.toDate());

                      final DatabaseService _db =
                          DatabaseService(farmerid: user.farmerId);

                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage:
                                          AssetImage('assets/temp.png'),
                                    ),
                                    trailing: Text('${farm.temp.toString()} °C',
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.blueGrey)),
                                    title: FlatButton(
                                      child: Text(
                                        'Temperature',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {
                                        navigateToSubPage(
                                            context, 'temperature');
                                      },
                                      //onPressed: () => (widget.visualizer('temperature')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage:
                                          AssetImage('assets/humidity.png'),
                                    ),
                                    trailing: Text(
                                        '${farm.humidity.toString()} %',
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.blueGrey)),
                                    title: FlatButton(
                                        child: Text(
                                          'Humidity',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {
                                          navigateToSubPage(
                                              context, 'humidity');
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage: AssetImage(
                                          'assets/soil_moisture.png'),
                                    ),
                                    trailing: Text(
                                        '${farm.soilMoisture.toString()} %',
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.blueGrey)),
                                    title: FlatButton(
                                        child: Text(
                                          'Soil Moisture',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {
                                          navigateToSubPage(
                                              context, 'soilMoisture');
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage: farm.pump
                                          ? AssetImage(
                                              'assets/irrigation_on.gif')
                                          : AssetImage(
                                              'assets/irrigation_off_1.PNG'),
                                    ),
                                    trailing: FlatButton(
                                      child: Text(pump,
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.blueGrey)),
                                      color: Colors.grey[300],

                                      //  Chang value of the pump and Send new data to database
                                      onPressed: () {
                                        setState(() {
                                          Map<String, Object> farmData = {
                                            'humidity': farm.humidity,
                                            'temp': farm.temp,
                                            'soil moisture': farm.soilMoisture,
                                            'timestamp': Timestamp.now(),
                                            'rooftop': farm.rooftop,
                                            'pump': !farm.pump,
                                          };
                                          _db.updateFarmData(farmData);
                                        });
                                        print('tapped');
                                      },
                                    ),
                                    title: FlatButton(
                                        child: Text(
                                          'Irrigation Pump',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {
                                          navigateToSubPage(
                                              context, 'pump_pie');
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage: farm.rooftop
                                          ? AssetImage('assets/open.png')
                                          : AssetImage('assets/close.png'),
                                    ),
                                    trailing: FlatButton(
                                        child: Text(rooftop,
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.blueGrey)),
                                        color: Colors.grey[300],
                                        onPressed: () {
                                          //  Chang value of the rooftop and Send new data to database

                                          setState(() {
                                            Map<String, Object> farmData = {
                                              'humidity': farm.humidity,
                                              'temp': farm.temp,
                                              'soil moisture':
                                                  farm.soilMoisture,
                                              'timestamp': Timestamp.now(),
                                              'rooftop': !farm.rooftop,
                                              'pump': farm.pump,
                                            };

                                            _db.updateFarmData(farmData);
                                          });
                                        }),
                                    title: FlatButton(
                                        child: Text(
                                          'Rooftop',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {
                                          navigateToSubPage(
                                              context, 'rooftop_pie');
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(child: Text('Last Updated at')),
                            Center(child: Text(updatedTime))
                          ],
                        ),
                      );
                    } else {
                      return Loading();
                    }
                  });
            } else {
              return Center(
                child: Text(
                  'Your farm is not Setuped',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                ),
              );
            }
          } else {
            return Loading();
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfs/models/farm.dart';
import 'package:sfs/models/user.dart';
import 'package:sfs/screens/home/sensordata/sensortile.dart';
import 'package:sfs/services/database.dart';
import 'package:sfs/shared/loading.dart';

class SensorData extends StatefulWidget {
  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<User>(
        stream: DatabaseService(farmerid: user.farmerId).userData,
        builder: (farmercontext, farmersnapshot) {
          if (farmersnapshot.hasData) {
            user = farmersnapshot.data;
          
            return StreamBuilder<List<Farm>>(
                stream: DatabaseService(farmerid: user.farmerId).farmData,
                builder: (farmcontext, farmsnapshot) {

                  if (farmsnapshot.hasData) {

                    user.farmlst = farmsnapshot.data; 
                    List<Farm> farmlst = user.farmlst;  

                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SenssorTile(),
                          SenssorTile(),
                        ],
                      ),
                    );
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

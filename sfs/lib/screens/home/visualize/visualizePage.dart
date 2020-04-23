import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfs/models/user.dart';
import 'package:sfs/screens/home/visualize/visualize.dart';
import 'package:sfs/services/authService.dart';

List<int> values = [5, 10, 15, 20, 25, 30, 40, 50, 60, 70, 80, 90, 100];
int countDataPoint = 25;

class VisualizePage extends StatefulWidget {
  @override
  _VisualizePageState createState() => _VisualizePageState();
}

Future navigateToSubPage(context, String visualizeDataOf) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return StreamProvider<User>.value(
        value: AuthService().user,
        child: Visualize(visualizeDataOf: visualizeDataOf, countDataPoint: countDataPoint),
      );
    }),
  );
}

class _VisualizePageState extends State<VisualizePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'How many Enrties do you want to visulaize?',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField(
              value: countDataPoint,
              items: values.map((val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(
                    '$val',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) => setState(() {
                countDataPoint = val;
              }),
            ),
            SizedBox(height: 30.0),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Temperature Line Chart',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    navigateToSubPage(context, 'temperature');
                  }),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Humidity Line Chart',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    navigateToSubPage(context, 'humidity');
                  }),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Soil Moisture Line Chart',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    navigateToSubPage(context, 'soilMoisture');
                  }),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Pump Line Chart',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    navigateToSubPage(context, 'pump');
                  }),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Pump Pie Chart',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    navigateToSubPage(context, 'pump_pie');
                  }),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Rooftop Line Chart',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    navigateToSubPage(context, 'rooftop');
                  }),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Rooftop Pie Chart',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    navigateToSubPage(context, 'rooftop_pie');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

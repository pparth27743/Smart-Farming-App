import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sfs/screens/home/account.dart';
import 'package:sfs/screens/home/prediction.dart';
import 'package:sfs/screens/home/sensordata/sensordata.dart';
import 'package:sfs/screens/home/vision.dart';
import 'package:sfs/screens/home/visualize/pieChart.dart';
import 'package:sfs/screens/home/visualize/visualizePage.dart';
import 'package:sfs/services/authService.dart';

class Home extends StatefulWidget {
  //
  String page;
  int selectedIndex;
  final Map<String, int> pageNameToIndex = {
    'prediction': 0,
    'vision': 1,
    'homepage': 2,
    'visualize': 3,
    'profile': 4
  };

  var widgetOptions;

  Home(this.page) {
    selectedIndex = pageNameToIndex[page];
    widgetOptions = [
      Prediction(),
      Vision(),
      SensorData(),
      VisualizePage(),
      Account(),
    ];
  }

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
      body: widget.widgetOptions.elementAt(widget.selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), title: Text('Predition')),
          BottomNavigationBarItem(
              icon: Icon(Icons.visibility), title: Text('Vision')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment), title: Text('visualize')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Profile')),
        ],
        currentIndex: widget.selectedIndex,
        fixedColor: Colors.green[600],
        backgroundColor: Colors.green[100],
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }
}

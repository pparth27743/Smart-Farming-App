import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sfs/screens/home/sensordata/sensordata.dart';
import 'package:sfs/services/authService.dart';
import 'package:sfs/services/database.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  void callfun (){

  }

  int selectedIndex = 2;
  final widgetOptions = [
    Text('Control'),
    Text('Vision'),
    SensorData(),
    Text('Visualize'),
    Text('Profile')
  ];

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
            icon: Icon(Icons.person),
            label: Text('Sign Out'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.security), title: Text('Contol ')),
          BottomNavigationBarItem(
              icon: Icon(Icons.visibility), title: Text('Vision')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment), title: Text('visualize')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Profile')),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.green[600],
        backgroundColor: Colors.green[100],
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}






















// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sfs/screens/home/sensordata/sensordat.dart';
// import 'package:sfs/services/authService.dart';
// import 'package:sfs/services/database.dart';

// class Home extends StatefulWidget {
//   @override
//   HomeState createState() => HomeState();
// }

// class HomeState extends State<Home> {
//   final AuthService _auth = AuthService();
//   final DatabaseService _db = DatabaseService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.green[100],
//         appBar: AppBar(
//           title: RichText(
//               text: TextSpan(
//                   text: 'SFS',
//                   style: GoogleFonts.lobster(
//                       fontSize: 40, color: Colors.brown[500]))),
//           backgroundColor: Colors.green[400],
//           elevation: 0.0,
//           actions: <Widget>[
//             FlatButton.icon(
//               icon: Icon(Icons.person),
//               label: Text('Sign Out'),
//               onPressed: () async {
//                 await _auth.signOut();
//               },
//             ),
//           ],
//         ),
//         body: Center(
//             child: RaisedButton(
//           child: Text('Tap'),
//           onPressed: () async {
//             SensorData();
//           },
//         )));
//   }
// }

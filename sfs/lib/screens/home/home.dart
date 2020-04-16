// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:sfs/models/user.dart';
// import 'package:sfs/screens/home/account.dart';
// import 'package:sfs/screens/home/prediction.dart';
// import 'package:sfs/screens/home/sensordata/sensordata.dart';
// import 'package:sfs/screens/home/vision.dart';
// import 'package:sfs/screens/home/visualize/pieChart.dart';
// import 'package:sfs/screens/home/visualize/visualizePage.dart';
// import 'package:sfs/services/authService.dart';
// import 'package:sfs/services/database.dart';
// import 'package:sfs/shared/loading.dart';

// class Home extends StatefulWidget {
//   //
//   String page;
//   int selectedIndex;
//   final Map<String, int> pageNameToIndex = {
//     'prediction': 0,
//     'vision': 1,
//     'homepage': 2,
//     'visualize': 3,
//     'profile': 4
//   };

//   var widgetOptions_old_user;
//   var widgetOptions_new_user;

//   Home(this.page) {
//     selectedIndex = pageNameToIndex[page];
//     widgetOptions_old_user = [
//       Prediction(),
//       Vision(),
//       SensorData(),
//       VisualizePage(),
//       Account(),
//     ];

//     widgetOptions_new_user = [
//       Prediction(),
//       Vision(),
//       HomeForNewUser(),
//       Account(),
//       Account(),
//     ];
//   }

//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   //
//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     User user = Provider.of<User>(context);

//     return StreamBuilder<User>(
//         stream: DatabaseService(farmerid: user.farmerId).userData,
//         builder: (farmercontext, farmersnapshot) {
//           if (farmersnapshot.hasData) {
//             user = farmersnapshot.data;

//             if (user.isFramAvailable) {
//               return Scaffold(
//                 backgroundColor: Colors.green[100],
//                 appBar: AppBar(
//                   title: RichText(
//                       text: TextSpan(
//                           text: 'SFS',
//                           style: GoogleFonts.lobster(
//                               fontSize: 40, color: Colors.brown[500]))),
//                   backgroundColor: Colors.green[400],
//                   elevation: 0.0,
//                   actions: <Widget>[
//                     FlatButton.icon(
//                       icon: Icon(
//                         Icons.exit_to_app,
//                         color: Colors.white,
//                       ),
//                       label: Text(
//                         'Sign Out',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                       onPressed: () async {
//                         await _auth.signOut();
//                       },
//                     ),
//                   ],
//                 ),
//                 body: widget.widgetOptions_old_user
//                     .elementAt(widget.selectedIndex),
//                 bottomNavigationBar: BottomNavigationBar(
//                   type: BottomNavigationBarType.fixed,
//                   items: [
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.show_chart),
//                         title: Text('Prediction')),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.visibility), title: Text('Vision')),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.home), title: Text('Home')),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.assessment), title: Text('visualize')),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.account_circle),
//                         title: Text('Profile')),
//                   ],
//                   currentIndex: widget.selectedIndex,
//                   fixedColor: Colors.green[600],
//                   backgroundColor: Colors.green[100],
//                   onTap: onItemTapped,
//                 ),
//               );
//             } else {
//               return Scaffold(
//                 backgroundColor: Colors.green[100],
//                 appBar: AppBar(
//                   title: RichText(
//                       text: TextSpan(
//                           text: 'SFS',
//                           style: GoogleFonts.lobster(
//                               fontSize: 40, color: Colors.brown[500]))),
//                   backgroundColor: Colors.green[400],
//                   elevation: 0.0,
//                   actions: <Widget>[
//                     FlatButton.icon(
//                       icon: Icon(
//                         Icons.exit_to_app,
//                         color: Colors.white,
//                       ),
//                       label: Text(
//                         'Sign Out',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                       onPressed: () async {
//                         await _auth.signOut();
//                       },
//                     ),
//                   ],
//                 ),
//                 body: widget.widgetOptions_new_user
//                     .elementAt(widget.selectedIndex),
//                 bottomNavigationBar: BottomNavigationBar(
//                   type: BottomNavigationBarType.fixed,
//                   items: [
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.show_chart),
//                         title: Text('Prediction')),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.visibility), title: Text('Vision')),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.home), title: Text('Home')),
//                     BottomNavigationBarItem(
//                         icon: Icon(Icons.account_circle),
//                         title: Text('Profile')),
//                   ],
//                   currentIndex: widget.selectedIndex,
//                   fixedColor: Colors.green[600],
//                   backgroundColor: Colors.green[100],
//                   onTap: onItemTapped,
//                 ),
//               );
//             }
//           } else {
//             return Loading();
//           }
//         });
//   }

//   void onItemTapped(int index) {
//     setState(() {
//       widget.selectedIndex = index;
//     });
//   }
// }

// Widget HomeForNewUser() {
//   return Center(
//     child: Text(
//       'Your farm is not Setuped',
//       style: TextStyle(
//           color: Colors.blueGrey, fontSize: 50, fontWeight: FontWeight.bold),
//       textAlign: TextAlign.center,
//     ),
//   );
// }

// // widget.widgetOptions_new_user
// //                     .elementAt(widget.selectedIndex),

// // bottomNavigationBar: BottomNavigationBar(
// //   type: BottomNavigationBarType.fixed,
// //   items: [
// //     BottomNavigationBarItem(
// //         icon: Icon(Icons.show_chart),
// //         title: Text('Prediction')),
// //     BottomNavigationBarItem(
// //         icon: Icon(Icons.visibility), title: Text('Vision')),
// //     BottomNavigationBarItem(
// //         icon: Icon(Icons.home), title: Text('Home')),
// //     BottomNavigationBarItem(
// //         icon: Icon(Icons.account_circle),
// //         title: Text('Profile')),
// //   ],
// //   currentIndex: widget.selectedIndex,
// //   fixedColor: Colors.green[600],
// //   backgroundColor: Colors.green[100],
// //   onTap: onItemTapped,
// // ),












import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sfs/models/user.dart';
import 'package:sfs/screens/home/account.dart';
import 'package:sfs/screens/home/prediction.dart';
import 'package:sfs/screens/home/sensordata/sensordata.dart';
import 'package:sfs/screens/home/vision.dart';
import 'package:sfs/screens/home/visualize/visualizePage.dart';
import 'package:sfs/services/authService.dart';
import 'package:sfs/services/database.dart';
import 'package:sfs/shared/loading.dart';

class Home extends StatefulWidget {
  //
  String page;

  int selectedIndex_old_user;
  int selectedIndex_new_user;

  final Map<String, int> pageNameToIndex = {
    'prediction': 0,
    'vision': 1,
    'homepage': 2,
    'visualize': 3,
    'profile': 4
  };

  var widgetOptions_old_user;
  var widgetOptions_new_user;

  Home(this.page) {
    selectedIndex_old_user = pageNameToIndex[page];
    widgetOptions_old_user = [
      Prediction(),
      Vision(),
      SensorData(),
      VisualizePage(),
      Account(),
    ];
    selectedIndex_new_user = 2;
    widgetOptions_new_user = [
      Prediction(),
      Vision(),
      HomeForNewUser(),
      Account()
    ];
  }

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<User>(
        stream: DatabaseService(farmerid: user.farmerId).userData,
        builder: (farmercontext, farmersnapshot) {
          if (farmersnapshot.hasData) {
            user = farmersnapshot.data;

            if (user.isFramAvailable) {
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
                body: widget.widgetOptions_old_user
                    .elementAt(widget.selectedIndex_old_user),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.show_chart),
                        title: Text('Prediction')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.visibility), title: Text('Vision')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text('Home')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.assessment), title: Text('visualize')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle),
                        title: Text('Profile')),
                  ],
                  currentIndex: widget.selectedIndex_old_user,
                  fixedColor: Colors.green[600],
                  backgroundColor: Colors.green[100],
                  onTap: onItemTapped_old_user,
                ),
              );
            } else {
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
                body: widget.widgetOptions_new_user
                    .elementAt(widget.selectedIndex_new_user),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.show_chart),
                        title: Text('Prediction')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.visibility), title: Text('Vision')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text('Home')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle),
                        title: Text('Profile')),
                  ],
                  currentIndex: widget.selectedIndex_new_user,
                  fixedColor: Colors.green[600],
                  backgroundColor: Colors.green[100],
                  onTap: onItemTapped_new_user,
                ),
              );
            }
          } else {
            return Loading();
          }
        });
  }

  void onItemTapped_old_user(int index) {
    setState(() {
      widget.selectedIndex_old_user = index;
    });
  }

  void onItemTapped_new_user(int index) {
    setState(() {
      widget.selectedIndex_new_user = index;
    });
  }
}

Widget HomeForNewUser() {
  return Center(
    child: Text(
      'Your farm is not Setuped',
      style: TextStyle(
          color: Colors.blueGrey, fontSize: 50, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}

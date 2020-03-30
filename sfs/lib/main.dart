import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfs/models/user.dart';
import 'package:sfs/screens/wrapper.dart';
import 'package:sfs/services/authService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamProvider<User>.value(
          value: AuthService().user, child: Wrapper()),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_circular_chart/flutter_circular_chart.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';



// class Account extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primaryColor: Color(0xffff6101),
//       ),
//       home: MyHomePage(title: 'Sales Dashboard 2018'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
//   var data1 = [0.0,-2.0,3.5,-2.0,0.5,0.7,0.8,1.0,2.0,3.0,3.2];

//   List<CircularStackEntry> circularData = <CircularStackEntry>[
//     new CircularStackEntry(
//       <CircularSegmentEntry>[
//         new CircularSegmentEntry(700.0, Color(0xff4285F4), rankKey: 'Q1'),
//         new CircularSegmentEntry(1000.0, Color(0xfff3af00), rankKey: 'Q2'),
//         new CircularSegmentEntry(1800.0, Color(0xffec3337), rankKey: 'Q3'),
//         new CircularSegmentEntry(1000.0, Color(0xff40b24b), rankKey: 'Q4'),
//       ],
//       rankKey: 'Quarterly Profits',
//     ),
//   ];



//   Material lineChart(String title, String priceVal,String subtitle) {
//     return Material(
//       color: Colors.white,
//       elevation: 15.0,
//       borderRadius: BorderRadius.circular(20.0),
//       shadowColor: Color(0x802196F3),
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.all(0.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.all(0.0),
//                     child: Text(title, style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.blueAccent,
//                     ),),
//                   ),

//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(priceVal, style: TextStyle(
//                       fontSize: 30.0,
//                     ),),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: Text(subtitle, style: TextStyle(
//                       fontSize: 20.0,
//                       color: Colors.blueGrey,
//                     ),),
//                   ),

//                   Padding(
//                     padding: EdgeInsets.all(1.0),
//                     child: new Sparkline(
//                       data: data,
//                       lineColor: Color(0xffff6101),
//                       pointsMode: PointsMode.all,
//                       pointSize: 8.0,
//                     ),
//                   ),

//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Container(
//           color:Colors.green[100],
//           child:StaggeredGridView.count(
//             crossAxisCount: 4,
//            crossAxisSpacing: 12.0,
//           mainAxisSpacing: 12.0,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: lineChart("Sales by Month","421.3M","+12.9% of target"),
//           ),

//         ],
//         staggeredTiles: [
//           StaggeredTile.extent(4, 250.0),
//         ],
//       ),
//       ),
//     );
//   }
// }
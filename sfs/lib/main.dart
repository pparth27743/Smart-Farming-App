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
// import 'package:sfs/stubPage.dart';

// void main() => runApp(App());

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Navigation',
//       home: MainPage(),
//     );
//   }
// }

// class MainPage extends StatelessWidget {

//   Future navigateToSubPage(context) async {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Main Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Click button to move to SubPage'),
//             RaisedButton(
//               textColor: Colors.white,
//               color: Colors.blue,
//               child: Text('Go to SubPage'),
//               onPressed: () {
//                 navigateToSubPage(context);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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



// // // import 'package:flutter/material.dart';
// // // import 'package:sfs/stubPage.dart';

// // // void main() => runApp(App());

// // // class App extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'Flutter Navigation',
// // //       home: MainPage(),
// // //     );
// // //   }
// // // }

// // // class MainPage extends StatelessWidget {

// // //   Future navigateToSubPage(context) async {
// // //     Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Main Page'),
// // //       ),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: <Widget>[
// // //             Text('Click button to move to SubPage'),
// // //             RaisedButton(
// // //               textColor: Colors.white,
// // //               color: Colors.blue,
// // //               child: Text('Go to SubPage'),
// // //               onPressed: () {
// // //                 navigateToSubPage(context);
// // //               },
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // // }

// // import 'package:flutter/material.dart';
// // import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// // import 'camera_preview_scanner.dart';
// // import 'material_barcode_scanner.dart';
// // import 'picture_scanner.dart';

// // void main() {
// //   runApp(
// //     MaterialApp(
// //       routes: <String, WidgetBuilder>{
// //         '/': (BuildContext context) => _ExampleList(),
// //         '/$PictureScanner': (BuildContext context) => PictureScanner(),
// //         '/$CameraPreviewScanner': (BuildContext context) =>
// //             CameraPreviewScanner(),
// //         '/$MaterialBarcodeScanner': (BuildContext context) =>
// //             const MaterialBarcodeScanner(),
// //       },
// //     ),
// //   );
// // }

// // class _ExampleList extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() => _ExampleListState();
// // }

// // class _ExampleListState extends State<_ExampleList> {
// //   static final List<String> _exampleWidgetNames = <String>[
// //     '$PictureScanner',
// //     '$CameraPreviewScanner',
// //     '$MaterialBarcodeScanner',
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Example List'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: _exampleWidgetNames.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           final String widgetName = _exampleWidgetNames[index];

// //           return Container(
// //             decoration: const BoxDecoration(
// //               border: Border(bottom: BorderSide(color: Colors.grey)),
// //             ),
// //             child: ListTile(
// //               title: Text(widgetName),
// //               onTap: () => Navigator.pushNamed(context, '/$widgetName'),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // // }





// // import 'package:sfs/testingNewthings/faceDetect.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';

// // void main() => runApp(MyApp());


// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         title: 'Face Detector',
// //         debugShowCheckedModeBanner: false,
// //         theme: ThemeData(
// //           primarySwatch: Colors.blue,
// //         ),
// //         home: FaceDetect(),
// //       );
// //   }
// // }







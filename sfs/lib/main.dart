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
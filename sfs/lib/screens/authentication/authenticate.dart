import 'package:flutter/material.dart';
import 'package:sfs/screens/authentication/forgotPwd.dart';
import 'package:sfs/screens/authentication/register.dart';
import 'package:sfs/screens/authentication/signIn.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  bool showResetPwd = false;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  void showResetPwdView() {
    setState(() => showResetPwd = !showResetPwd);
  }

  @override
  Widget build(BuildContext context) {
    if (showResetPwd) {
      return ForgotPassword(showResetPwdView: showResetPwdView);
    } else {
      if (showSignIn) {
        return SignIn(
            toggleView: toggleView, showResetPwdView: showResetPwdView);
      } else {  
        return Register(toggleView: toggleView);
      }
    }
  }
}

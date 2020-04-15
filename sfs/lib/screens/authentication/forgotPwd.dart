import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sfs/screens/authentication/signIn.dart';
import 'package:sfs/services/authService.dart';
import 'package:sfs/shared/constant.dart';


class ForgotPassword extends StatefulWidget {

  final Function showResetPwdView;

  ForgotPassword({this.showResetPwdView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<ForgotPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String error = '';
  String msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.green[100],
            appBar: AppBar(
                backgroundColor: Colors.green[400],
                //  elevation: 0.0,
                title: Text("Reset Password")),
            body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 50,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        RichText(
                            text: TextSpan(
                                text: 'SFS',
                                style: GoogleFonts.lobster(
                                    fontSize: 100, color: Colors.brown[400]))),
                        SizedBox(height: 30.0),
                        Text(
                          msg,
                          style: TextStyle(color: Colors.indigo, fontSize: 22.0),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.green[400],
                            child: Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => msg = 'Reset link has been to $email');
                                dynamic result = await _auth.resetPwd(email);
                              }   
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(height: 00),
                        FlatButton(
                          child: Text(
                            'Return to Sign In?',
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: widget.showResetPwdView,
                        ),
                      ],
                    ),
                  )),
            ),
          );
  }
}

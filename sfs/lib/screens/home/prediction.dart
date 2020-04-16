import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sfs/services/authService.dart';
import 'package:sfs/shared/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.43.114:6000";

class Prediction extends StatefulWidget {
  final Function toggleView;
  Prediction({this.toggleView});

  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isPredicted = false;
  bool isServerDown = false;
  String temp;
  String humi;
  List<String> lst = new List<String>();
  String predResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 50,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: 'Crop prediction',
                        style: GoogleFonts.lobster(
                            fontSize: 50, color: Colors.blueGrey)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Temperature (°C)' +
                        '                                                                                                                                                                                                                            ',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: '35'),
                    enabled: true,
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val.isEmpty ? 'Enter Temperature Value' : null,
                    onChanged: (val) {
                      setState(() => temp = val);
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Humidity (%)' +
                        '                                                                                                                                                                                                                                                                                        ',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Range 0 - 100'),
                    enabled: true,
                    keyboardType: TextInputType.number,
                    validator: (val) => (val.isEmpty ||
                            int.parse(val) < 0 ||
                            int.parse(val) > 100)
                        ? 'Enter a valid Humidity Value'
                        : null,
                    onChanged: (val) {
                      setState(() => humi = val);
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.green[400],
                      child: Text(
                        'Predict',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            var response = await http.post(baseUrl,
                                body: json.encode({
                                  'temperature': temp.toString(),
                                  'humidity': humi.toString()
                                }),
                                headers: {'content-type': 'application/json'});
                            print('Response status: ${response.statusCode}');
                            print(
                                'Response body: ${json.decode(response.body)['prediction']}');

                            String tmp =
                                json.decode(response.body)['prediction'];
                            int openingInd = 0;
                            int closingInd = 0;
                            bool firstSymOrNot = true;

                            setState(() {
                              for (int i = 0; i < tmp.length; i++) {
                                if (tmp[i] == '\'' && firstSymOrNot == true) {
                                  openingInd = i + 1;
                                  firstSymOrNot = false;
                                } else if (tmp[i] == '\'' &&
                                    firstSymOrNot == false) {
                                  closingInd = i;
                                  firstSymOrNot = true;
                                  lst.add(
                                      tmp.substring(openingInd, closingInd));
                                }
                              }

                              predResult = '';
                              if (lst.length != 0) {
                                for (int i = 0; i < lst.length; i++) {
                                  predResult += lst[i];
                                  if (i != lst.length - 1) {
                                    predResult += ', ';
                                  }
                                }
                              } else {
                                predResult =
                                    'For given values data in not available';
                              }
                              lst.clear();
                              isPredicted = true;
                              isServerDown = false;
                            });
                          } catch (e) {
                            print('There is some Problem');
                            print(e.toString());
                            setState(() {
                              isServerDown = true;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  if (isPredicted) ...[
                    Text(
                      'Follwing are the Crops can be grown on your field:' +
                          '                                                                                                                                                                                                                            ',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${predResult}' +
                          '                                                                                                                                                                                                                            ',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                  if (isServerDown) ...[
                    Text(
                      'Server is not available at this moment.' +
                          '                                                                                                                                                                                                                            ',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ],
              ),
            )),
      ),
    );
  }
}

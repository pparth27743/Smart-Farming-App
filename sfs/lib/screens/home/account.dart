import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfs/models/user.dart';
import 'package:sfs/services/authService.dart';
import 'package:sfs/services/database.dart';
import 'package:sfs/shared/constant.dart';
import 'package:sfs/shared/loading.dart';
import 'package:google_fonts/google_fonts.dart';

String email;
String fullName;
int day;
int month;
int year;
bool isFarmAvailable;
String gender;

List<String> genders = ['Male', 'Female', 'Transgender', 'Rather not say'];
enum farmAvailable { YES, NO }
farmAvailable val_farmAvailable = null;
bool isDateSelected = false;

class Account extends StatefulWidget {
  final Function toggleView;
  Account({this.toggleView});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<User>(
        stream: DatabaseService(farmerid: user.farmerId).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data;

            if (val_farmAvailable == null) {
              if (user.isFramAvailable) {
                val_farmAvailable = farmAvailable.YES;
              } else {
                val_farmAvailable = farmAvailable.NO;
              }
            }
            final DatabaseService _db =
                DatabaseService(farmerid: user.farmerId);

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
                                  text: 'Profile',
                                  style: GoogleFonts.lobster(
                                      fontSize: 50, color: Colors.blueGrey))),
                          SizedBox(height: 20.0),
                          Text(
                            'Full Name' +
                                '                                                                                                                                                                                                                                          ',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: user.fullName),
                            enabled: true,
                            onChanged: (val) {
                              setState(() => fullName = val);
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Email' +
                                '                                                                                                                                                                                                                                                      ',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: user.email),
                            enabled: false,
                            validator: (val) =>
                                val.isEmpty ? 'Enter a Email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Text(
                                'Date of Birth' + '                         ',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 20),
                              ),
                              IconButton(
                                icon: Icon(Icons.calendar_today),
                                color: Colors.blueGrey,
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now())
                                      .then((date) {
                                    setState(() {
                                      day = date.day;
                                      month = date.month;
                                      year = date.year;
                                      isDateSelected = true;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                isDateSelected
                                    ? '${day}/${month}/${year}'
                                    : '${user.day}/${user.month}/${user.year}',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Gender' +
                                '                                                                                                                                                                                                                                                      ',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                          DropdownButtonFormField(
                            hint: Text(
                              user.gender,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: gender,
                            items: genders.map((gen) {
                              return DropdownMenuItem(
                                value: gen,
                                child: Text(
                                  '$gen',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) => setState(() {
                              gender = val;
                            }),
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            'Want to enable the Smart Farm System?',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 40),
                              Text("YES",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Radio(
                                value: farmAvailable.YES,
                                groupValue: val_farmAvailable,
                                activeColor: Colors.blue,
                                onChanged: (val) {
                                  setState(() {
                                    val_farmAvailable = val;
                                    isFarmAvailable = true;
                                  });
                                },
                              ),
                              SizedBox(width: 60),
                              Text("NO",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Radio(
                                value: farmAvailable.NO,
                                groupValue: val_farmAvailable,
                                activeColor: Colors.blue,
                                onChanged: (val) {
                                  setState(() {
                                    val_farmAvailable = val;
                                    isFarmAvailable = false;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.green[400],
                              child: Text(
                                'Update Data',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                User usr = new User(
                                    email: email ?? user.email,
                                    fullName: fullName ?? user.fullName,
                                    day: day ?? user.day,
                                    month: month ?? user.month,
                                    year: year ?? user.year,
                                    gender: gender ?? user.gender,
                                    isFramAvailable: isFarmAvailable ??
                                        user.isFramAvailable);

                                _db.updateUserData(usr);

                                // print(usr.email);
                                // print(usr.fullName);
                                // print(usr.day);
                                // print(usr.month);
                                // print(usr.year);
                                // print(usr.gender);
                                // print(usr.isFramAvailable);
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

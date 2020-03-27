import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sfs/screens/authentication/authenticate.dart';
import 'package:sfs/screens/home/home.dart';
import 'package:sfs/models/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {  
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
} 

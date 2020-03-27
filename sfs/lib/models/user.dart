import 'package:sfs/models/farm.dart';

class User {
  final String farmerId;

  User({this.farmerId});
}

class UserData {
  final String farmerId;
  List<Farm> farmlst = [];


  UserData({this.farmerId});
}

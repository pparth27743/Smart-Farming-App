import 'package:sfs/models/farm.dart';

class User {
  final String farmerId;
  final String email;
  final String fullName;
  final int day;
  final int month;
  final int year;
  final String gender;
  final bool isFramAvailable;
  List<Farm> farmlst = [];

  User(
      {this.farmerId,
      this.email,
      this.fullName,
      this.day,
      this.month,
      this.year,
      this.gender,
      this.isFramAvailable});
}

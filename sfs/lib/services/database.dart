import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sfs/models/user.dart';

class DatabaseService {
  final String farmerid;

  DatabaseService({this.farmerid});

  // Collection Reference
  final collectionFarmer  = Firestore.instance.collection('farmers');


  User farmerDataSnapshot(QuerySnapshot snapshot) {
        
    return null;
  }

}
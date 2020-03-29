import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sfs/models/farm.dart';
import 'package:sfs/models/user.dart';

class DatabaseService {
  final String farmerid;

  DatabaseService({this.farmerid});

  // Collection Reference
  final collectionFarmer = Firestore.instance.collection('farmers');

  // Set data
  Future updateUserData(String email) async {
    return await collectionFarmer.document(farmerid).setData({'email': email});
  }

  List<Farm> _framDataFromSanpshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Farm(
          farmerId: farmerid,
          id: doc.documentID,
          humidity: doc.data['humidity'],
          soilMoisture: doc.data['soil moisture'],
          temp: doc.data['temp'],
          pump: doc.data['pump'],
          rooftop: doc.data['rooftop'],
          timestamp: doc.data['timestamp']);
    }).toList();
  }

  Stream<List<Farm>> get allFarmData {
    final collectionFarm =
        collectionFarmer.document(farmerid).collection('farm');
    return collectionFarm.snapshots().map(_framDataFromSanpshot);
  }

  Stream<List<Farm>> get latestFarmData {
    final collectionFarm =
        collectionFarmer.document(farmerid).collection('farm');
    return collectionFarm
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map(_framDataFromSanpshot);
  }

  User _farmerDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(farmerId: farmerid, email: snapshot.data['email']);
  }

  Stream<User> get userData {
    return collectionFarmer
        .document(farmerid)
        .snapshots()
        .map(_farmerDataFromSnapshot);
  }
}

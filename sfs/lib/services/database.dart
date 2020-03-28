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
      //print(doc.documentID);
      return Farm(
          farmerId: farmerid ?? null,
          farmId:  doc.documentID ?? null,
          humidity: doc.data['humidity'] ?? -999,
          soil_moisture: doc.data['soil mositure'] ?? -999,
          temp: doc.data['temp'] ?? -999,
          pump: doc.data['pump'] ?? false,
          rooftop: doc.data['rooftop'] ?? false);
    }).toList();
  }

  User _farmerDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(farmerId: farmerid, email: snapshot.data['email']);
  }


  Stream<List<Farm>> get farmData {
    
    final collectionFarm = collectionFarmer.document(farmerid).collection('farm');
    return collectionFarm.snapshots().map(_framDataFromSanpshot);
  }

  Stream<User> get userData {
    return collectionFarmer
        .document(farmerid)
        .snapshots()
        .map(_farmerDataFromSnapshot);
  }
}

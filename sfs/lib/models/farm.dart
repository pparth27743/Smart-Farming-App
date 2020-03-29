import 'package:cloud_firestore/cloud_firestore.dart';

class Farm {
  final String farmerId;
  final String id;
  final int humidity;
  final int soilMoisture;
  final int temp;
  final bool pump;
  final bool rooftop;
  final Timestamp timestamp;

  Farm(
      {this.farmerId,
      this.id,
      this.humidity,
      this.soilMoisture,
      this.temp,
      this.pump,
      this.rooftop,
      this.timestamp});
}

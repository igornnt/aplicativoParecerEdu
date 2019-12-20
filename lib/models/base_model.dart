import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel {

  BaseModel.fromFirestore(DocumentSnapshot documento);
  Map<String, dynamic> toMap();
}
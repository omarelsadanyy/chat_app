
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
 final String id;
 final String message;
 final Timestamp createdAt;


  MessageModel({required this.id, required this.message ,required this.createdAt});

  factory MessageModel.fromJson( json) {
    return MessageModel(
      id: json['id'],
      message: json['message'],
      createdAt: json['createdAt'] ,
    );
  }
}
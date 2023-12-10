import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({required this.senderEmail, 
  required this.message, 
  required this.receiverId, 
  required this.senderId, 
  required this.timestamp});

  //convert to a map

  Map<String, dynamic> toMap(){
    return {
      'sernderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,




    };

  }


}
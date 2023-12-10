import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencychat/model/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;


  //enviar mensajes

  Future<void> sendMessage(String receiverId, String message) async{

    //currente info

    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();





    //crear nuevo mensaje

    Message newMessage = Message(
      senderId: currentUserId, 
      message: message, 
      receiverId: receiverId, 
      senderEmail: currentUserEmail, 
      timestamp: timestamp);


    //construir el room

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _fireStore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());


    //agregar nuevo mensaje


    //


  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId ){

    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore.collection('chat_rooms')
    .doc(chatRoomId)
    .collection('messages')
    .orderBy('timestamp', descending: false).snapshots();

  }


}
import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
CollectionReference messageCollection = FirebaseFirestore.instance.collection(
    kmessagesCollection,);
  List<MessageModel> messageList = [];
  void sendMessage(String value, String email) {
    messageCollection.add({'message': value, 'createdAt': Timestamp.now(), 'id': email});
  
  }

  void getMessages() {
    messageCollection.orderBy('createdAt', descending: true).snapshots().listen((event) {
      messageList.clear();
      emit(ChatLoading());
      for (var doc in event.docs) {
       messageList.add(MessageModel.fromJson(doc));
      }
       emit(ChatSuccess(messageList));
    });
  }
}

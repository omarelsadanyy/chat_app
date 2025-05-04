import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key, required this.message,
  });
   final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text( 
          '${message.createdAt.toDate().hour}:${message.createdAt.toDate().minute} ${message.createdAt.toDate().hour > 12 ? 'PM' : 'AM'}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            padding: EdgeInsets.only(left:16,top: 22,bottom :22,right :16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),   
              ),
              color: kprimaryColor
            ),
            child: Text(
              message.message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class ChatBubbleSecondUser extends StatelessWidget {
  const ChatBubbleSecondUser({
    super.key, required this.message,
  });
   final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text( 
          '${message.createdAt.toDate().hour}:${message.createdAt.toDate().minute} ${message.createdAt.toDate().hour > 12 ? 'PM' : 'AM'}',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            padding: EdgeInsets.only(left:16,top: 22,bottom :22,right :16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),   
              ),
              color: kprimaryColorLight
            ),
            child: Text(
              message.message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
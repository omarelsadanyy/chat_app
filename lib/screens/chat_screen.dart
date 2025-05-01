import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_babble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'ChatScreen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messageCollection = FirebaseFirestore.instance.collection(
    kmessagesCollection,
  );
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messageCollection.orderBy('createdAt',descending: true).snapshots(),
      builder: (BuildContext context, Snapshot) {
        if (Snapshot.hasData) {
          List<MessageModel> messageList = [];
          for (int i = 0; i < Snapshot.data!.docs.length; i++) {
            messageList.add(MessageModel.fromJson(Snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kprimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(scholarImage, height: 50),
                  Text('Chat App'),
                ],
              ),
              titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return  messageList[index].id ==email ? 
                      ChatBubble(message: messageList[index]):
                      ChatBubbleSecondUser(message: messageList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: kprimaryColor),
                        onPressed: () {
                          String text = messageController.text;
                          if (text.isNotEmpty) {
                            _onSubmitted(text, email);
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide(color: kprimaryColor),
                      ),
                    ),
                    // the below line is commented out because when pressing enter or done it sends a empty message
                    //onSubmitted: (text) => _onSubmitted(text, email),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: kprimaryColor,
            ),
          );
        }
      },
    );
  }

  void _onSubmitted(String value, String email) {
    messageCollection.add({'message': value, 'createdAt': Timestamp.now(), 'id': email});
    scrollController.animateTo(
      0,
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
    );
    messageController.clear();
  }
}

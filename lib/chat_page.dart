import 'package:chat_app/models/chat_message_entity.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  List<ChatMessageEntity> _messages = [
    ChatMessageEntity(
        author: Author(userName: 'Jesh'),
        createdAt: 21452315,
        id: '1',
        text: 'Wazzup!'
    ),
    ChatMessageEntity(
      author: Author(userName: 'Jesh'),
      createdAt: 21452315,
      id: '1',
      text: 'Hey yow!',
      imageUrl:  'https://cdn.pixabay.com/photo/2015/10/31/17/33/press-1015988_1280.jpg',
    ),
    ChatMessageEntity(
      author: Author(userName: 'Josh'),
      createdAt: 21452315,
      id: '1',
      text: 'Gottch',
    ),
  ];

  @override
  Widget build(BuildContext context) {

    final username = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi $username!'),
        actions: [
          IconButton(
              onPressed: () {

                Navigator.pushReplacementNamed(context, '/');
                print('Icon pressed!');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index){
                  return ChatBubble(
                      alignment: _messages[index].author.userName == 'Jesh'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      entity: _messages[index]);
                }
            ),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
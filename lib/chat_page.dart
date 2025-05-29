import 'dart:convert';
import 'package:chat_app/models/image_model.dart';
import 'package:chat_app/repo/image_repository.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/chat_message_entity.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageEntity> _messages = [];
  List<PixelfordImage> _images = [];
  bool _isLoadingImages = true;

  final ImageRepository _imageRepo = ImageRepository();

  @override
  void initState() {
    _loadInitialMessages();
    _imageRepo.getNetworkImages().then((imgs) {
      setState(() {
        _images = imgs;
        _isLoadingImages = false;
      });
    }).catchError((e) {
      print("Failed to load images: $e");
      setState(() => _isLoadingImages = false);
    });
    super.initState();
  }

  _loadInitialMessages() async {
    rootBundle.loadString('assets/mock_messages.json').then((response) {
      final List<dynamic> decodeList = jsonDecode(response) as List;
      final List<ChatMessageEntity> _chatMessages = decodeList.map((listItem) {
        return ChatMessageEntity.fromJson(listItem);
      }).toList();
      setState(() {
        _messages = _chatMessages;
      });
    }).then((_) {
      print('Done!');
    });
  }

  onMessageSent(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final username = context.watch<AuthService>().getUserName();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi $username!'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthService>().updateUserName('New Name!');
              },
              icon: Icon(Icons.refresh)
          ),
          IconButton(
              onPressed: () async {
                context.read<AuthService>().logoutUser();
                Navigator.pushReplacementNamed(context, '/');
                print('Icon pressed!');
              },
              icon: Icon(Icons.logout)
          ),
        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  alignment: _messages[index].author.username ==
                      context.read<AuthService>().getUserName()
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  entity: _messages[index],
                );
              },
            ),
          ),
          ChatInput(
            onSubmit: onMessageSent,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget{
  final String message;
  final Alignment alignment;
  const ChatBubble({Key? key, required this.alignment, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$message',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Image.network(
              'https://cdn.pixabay.com/photo/2015/10/31/17/33/press-1015988_1280.jpg',
              height: 200,
            )
          ],
        ),
        margin: EdgeInsets.all(50),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
      ),
    );
  }
}
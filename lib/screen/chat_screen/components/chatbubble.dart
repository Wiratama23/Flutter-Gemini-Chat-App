import 'package:buatapa/screen/chat_screen/chat_controller.dart';
import 'package:buatapa/screen/chat_screen/components/imagebubble.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.controller,
  });

  final Map<String, dynamic> message;
  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        controller.copyToClipboard(context, message['message']!);
      },
      child: Container(
          alignment: message['sender'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: message['sender'] == 'user' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade200
                  ),
                  child: Text(controller.displayCurrentRes(message['sender'])),
                ),
                const SizedBox(height: 5),
                message['image_path']?.isNotEmpty == true
                    ?  ImageBubble(message: message)
                    : Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.all(Radius.circular(15))
                        ),
                        child: Text(message['message']!)),
              ],
            ),
          )
      ),
    );
  }
}
import 'dart:io';

import 'package:flutter/material.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({
    super.key,
    required this.message,
  });

  final Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(message['message']!),
          // const Divider(
          //   thickness: 1,
          //   color: Colors.black26,
          // ),
          Image.file(File(message['image_path']!), height: 200, width: 200)
        ],
      ),
    );
  }
}
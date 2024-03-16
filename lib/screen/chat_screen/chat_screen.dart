import 'package:buatapa/screen/chat_screen/chat_controller.dart';
import 'package:buatapa/screen/chat_screen/components/chatbubble.dart';
import 'package:buatapa/screen/chat_screen/components/inputtextfield.dart';
import 'package:buatapa/screen/chat_screen/components/loadbubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Chat Screen",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,

      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black54
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: Obx(
                    () => ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        var message = controller.messages[index];
                        return ChatBubble(message: message, controller: controller);
                      }
                    ),
                  )),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.isLoading.value
                      ? const LoadComp()
                      : InputTextFields(controller: controller),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

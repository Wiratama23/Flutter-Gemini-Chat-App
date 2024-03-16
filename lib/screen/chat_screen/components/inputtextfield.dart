import 'package:buatapa/screen/chat_screen/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputTextFields extends StatelessWidget {
  const InputTextFields({
    super.key,
    required this.controller,
  });

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          Obx(
            () => IconButton(
                onPressed: (){
                  FocusScope.of(context).unfocus();
                  controller.pickImage();
                },
                icon: controller.hasImages.value
                    ? Image.file(controller.imageFiles!, width: 24, height: 24)
                    : const Icon(Icons.image)
            ),
          ),
          Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 5,
                controller: controller.userInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade400)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade400)
                    ),
                    fillColor: Colors.grey[400],
                    filled: true,
                    hintText: "Chat Here",
                    hintStyle: const TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                        onPressed: (){
                          FocusScope.of(context).unfocus();
                          controller.userInputs(controller.userInput.text);
                        },
                        icon: const Icon(Icons.transit_enterexit)
                    ),
                ),
                onSubmitted: (text){
                  controller.userInputs(text);
                },
              )
          ),
        ],
      ),
    );
  }
}
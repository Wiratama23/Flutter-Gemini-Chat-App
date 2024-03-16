import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  TextEditingController userInput = TextEditingController();
  ScrollController scrollController = ScrollController();

  static const String urls = "APIURL"; //API URL
  static const String token = "APITOKEN"; //API TOKEN
  bool isUser = false;
  // List<Map<String, String>> messages = [
  //   {'sender': 'user','message': 'hey bro'},
  //   {'sender': 'bot','message': 'hello'}
  // ];
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  RxBool hasImages = false.obs;
  RxBool isLoading = false.obs;
  File? imageFiles;
  String pickedImagePath = '';

  String displayCurrentRes(String user){
    var name="";
    if(user == "user"){
      name = "Anda";
    } else {
      name = "Gemini";
    }
    return name;
  }
  void inputProcess(String input, String pickimage){
    var data = {
      'sender': 'user',
      'message': input,
      'image_path': pickimage

    };
    messages.add(data);
    update();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

  }

  void userInputs(String input){
    if(input.isNotEmpty){
      input = input.trim();
      inputProcess(input, pickedImagePath);
      isLoading.value = true;

      if(hasImages.value){
        sendImagePrompt(input, imageFiles!);
      } else {
        sendTextPrompt(input);
      }
    } else {
      Get.snackbar(
          "Empty",
          "Please Fill the textfield",
          colorText: Colors.black,
          backgroundColor: Colors.grey.shade300
      );
    }
    pickedImagePath = '';
    userInput.clear();

  }

  Future<void> sendTextPrompt(String input) async {
    try {
      final url = Uri.parse(urls);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "messages": messages.map((message) {
            return {
              "chatPrompt": message['sender'] == 'user' ? message['message'] : '',
              "botMessage": message['sender'] == 'bot' ? message['message'] : '',
            };
          }).toList(),
          "userInput": input,
        }),
      );
      handleResponse(response);
    } catch (error) {
      Get.snackbar(
          "Error",
          "error message: $error",
          colorText: Colors.black,
          backgroundColor: Colors.grey.shade300
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendImagePrompt(String input, File imageFile) async {

    try {
      hasImages.value = false;
      final Uri url = Uri.parse('https://us-central1-unik-3f23e.cloudfunctions.net/chatprompt/imageprompt');

      var request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer $token';
      request.fields['prompt'] = input;

      var imageStream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      request.files.add(http.MultipartFile('files', imageStream, length, filename: 'image.jpg'));

      var response = await request.send();
      handleResponse(await http.Response.fromStream(response));
    } catch (error) {
      Get.snackbar(
          "Error",
          "Error message: $error",
          colorText: Colors.black,
          backgroundColor: Colors.grey.shade300
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<File?> getImageFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      Get.snackbar(
          "Error",
          "No image selected",
          colorText: Colors.black,
          backgroundColor: Colors.grey.shade300
      );
      return null;
    }
  }

  Future<void> pickImage() async {
    imageFiles = await getImageFile();
    if (imageFiles != null) {
      hasImages.value = true;
      pickedImagePath = imageFiles!.path;
    }
  }

  void handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      messages.add({
        'sender': 'bot',
        'message': data['botResponse'],
      });
      update();
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      Get.snackbar(
          "Error",
          "${response.statusCode}",
          colorText: Colors.black,
          backgroundColor: Colors.grey.shade300
      );
      // print('Failed to load data. Status code: ${response.statusCode}');
    }
  }

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      "Copy",
      "Text Copied to Clipboard",
      colorText: Colors.black,
      backgroundColor: Colors.grey.shade300
    );
  }
}

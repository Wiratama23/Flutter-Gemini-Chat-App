import 'package:buatapa/router/route_names.dart';
import 'package:buatapa/screen/chat_screen/chat_controller.dart';
import 'package:buatapa/screen/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

class Routes {
  static final pages = [
    GetPage(
        name: Names.pageChat,
        page: () => const ChatScreen(),
        binding: BindingsBuilder((){
          Get.put(ChatController());
        })
    ),
  ];
}
import 'package:buatapa/router/route_names.dart';
import 'package:buatapa/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "demo",
      initialRoute: Names.pageChat,
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,

    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.put(Controller());
  runApp(App());
}

class Controller extends GetxController {
  final box = GetStorage();
  bool get isDark => box.read('darkmode') ?? false;
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void changeTheme(bool val) {
    box.write('darkmode', val);
    refresh();
  }
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Controller controller = Get.find<Controller>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (controller) {
      print("Rebuilding App with theme: ${controller.theme}");
      print("Is dark mode: ${controller.isDark}");
      return MaterialApp(
        theme: controller.theme,
        themeMode: controller.isDark ? ThemeMode.dark : ThemeMode.light,
        home: Scaffold(
          appBar: AppBar(title: Text("Get Storage")),
          body: Center(
            child: SwitchListTile(
              value: controller.isDark,
              title: Text("Touch to change ThemeMode"),
              onChanged: controller.changeTheme,
            ),
          ),
        ),
      );
    });
  }
}

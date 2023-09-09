import 'package:flutter/material.dart';
import 'package:platform_convertor_application_project/components/CallsPage.dart';
import 'package:platform_convertor_application_project/components/ChatsPage.dart';
import 'package:platform_convertor_application_project/components/SettingPage.dart';
import 'package:platform_convertor_application_project/controller/platformConverter.dart';
import 'package:provider/provider.dart';

import '../../components/addPersonPage.dart';
import '../../controller/themeController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Chat App",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Icon(
                Icons.person_add_alt_outlined,
                size: 28,
              ),
              Text(
                "CHATS",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "CALLS",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "SETTING",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            Consumer<PlatformController>(builder: (context, pro, _) {
              return Switch(
                value: pro.getPlatformConverter,
                onChanged: (val) {
                  pro.changePlatform();
                },
              );
            })
          ],
        ),
        body: TabBarView(
          children: [
            AddPersonPage(),
            ChatsPage(),
            CallsPage(),
            SettingPage(),
          ],
        ),
      ),
    );
  }
}

// body: Consumer<themeController>(builder: (context, pro, _) {
//   return Switch(
//       value: pro.getTheme,
//       onChanged: (val) {
//         pro.changeTheme();
//       });
// }),

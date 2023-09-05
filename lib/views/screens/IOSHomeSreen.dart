import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convertor_application_project/components/IosCallsPage.dart';
import 'package:platform_convertor_application_project/components/IosChatPage.dart';
import 'package:platform_convertor_application_project/components/iosAddPersonPage.dart';
import 'package:platform_convertor_application_project/components/iosSettingPage.dart';
import 'package:platform_convertor_application_project/controller/platformConverter.dart';
import 'package:provider/provider.dart';

import '../../controller/themeController.dart';

class IosHomePage extends StatelessWidget {
  IosHomePage({super.key});

  List pages = [
    IosAddPersonPage(),
    IosChatPage(),
    IosCallsPage(),
    IosSettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("HomePage"),
        trailing: Consumer<PlatformController>(
          builder: (context, pro, _) {
            return CupertinoSwitch(
              onChanged: (val) {
                pro.changePlatform();
              },
              value: pro.getPlatformConverter,
            );
          },
        ),
      ),
      child: CupertinoTabScaffold(
        tabBuilder: (Context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 80, horizontal: 16),
          child: pages[index],
        ),
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_add), label: "CONTACTS"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2), label: "CHATS"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone), label: "CALLS"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: "SETTING"),
          ],
        ),
      ),
    );
  }
}

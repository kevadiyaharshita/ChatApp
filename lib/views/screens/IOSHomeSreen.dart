import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convertor_application_project/components/IosCallsPage.dart';
import 'package:platform_convertor_application_project/components/IosChatPage.dart';
import 'package:platform_convertor_application_project/components/iosAddPersonPage.dart';
import 'package:platform_convertor_application_project/components/iosSettingPage.dart';
import 'package:platform_convertor_application_project/controller/platformConverter.dart';
import 'package:platform_convertor_application_project/utils/ColorUtils.dart';
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
        middle: Text(
          "Chat App",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        trailing: Consumer<PlatformController>(
          builder: (context, pro, _) {
            return CupertinoSwitch(
              thumbColor: CupertinoColors.white,
              activeColor: theme_Color1,
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
          padding: EdgeInsets.symmetric(
              vertical: (index == 0) ? 80 : 10,
              horizontal: (index == 0) ? 16 : 5),
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

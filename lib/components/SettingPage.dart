import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/themeController.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          Consumer<themeController>(
            builder: (context, pro, _) {
              return Switch(
                value: pro.getTheme,
                onChanged: (val) {
                  pro.changeTheme();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

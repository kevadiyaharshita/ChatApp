import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/SplashScreenController.dart';
import '../../controller/platformConverter.dart';
import '../../controller/themeController.dart';
import '../../utils/MyRoutes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    changepage() {
      Timer.periodic(Duration(seconds: 4), (timer) {
        Provider.of<SplashScreenController>(context, listen: false)
            .changeSplash();
        Navigator.of(context).pushReplacementNamed(
            (Provider.of<PlatformController>(context, listen: false)
                    .getPlatformConverter)
                ? IOSMyRoutes.home
                : MyRoutes.home);
        timer.cancel();
      });
    }

    changepage();
    return Consumer<ThemeController>(
      builder: (context, pro, _) {
        return Scaffold(
          body: Center(
            child: Image(
              image: AssetImage((pro.getTheme)
                  ? 'assets/images/Splash_Dark.gif'
                  : 'assets/images/Splash_Light.gif'),
            ),
          ),
          backgroundColor: pro.getTheme ? Color.fromRGBO(25, 24, 24, 1) : null,
        );
      },
    );
  }
}

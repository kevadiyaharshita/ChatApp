import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:platform_convertor_application_project/components/ModalBottomSheetController.dart';
import 'package:platform_convertor_application_project/controller/ContactController.dart';
import 'package:platform_convertor_application_project/controller/ProfileController.dart';
import 'package:platform_convertor_application_project/utils/ColorUtils.dart';
import 'package:platform_convertor_application_project/utils/MyRoutes.dart';
import 'package:platform_convertor_application_project/views/screens/HomePage.dart';
import 'package:platform_convertor_application_project/views/screens/IOSHomeSreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/DateTimeController.dart';
import 'controller/ModalBottomSheetController.dart';
import 'controller/platformConverter.dart';
import 'controller/themeController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeController(preferences: preferences),
        ),
        ChangeNotifierProvider(
          create: (context) => PlatformController(preferences: preferences),
        ),
        ChangeNotifierProvider(
          create: (context) => DateTimeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactController(preferences: preferences),
        ),
        ChangeNotifierProvider(
          create: (context) => ModalSheetVisibility(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileController(preferences: preferences),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (Provider.of<PlatformController>(context).getPlatformConverter)
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              primaryColor: theme_Color1,
              brightness: (Provider.of<ThemeController>(context).getTheme)
                  ? Brightness.dark
                  : Brightness.light,
            ),
            initialRoute: IOSMyRoutes.home,
            routes: {
              IOSMyRoutes.home: (context) => IosHomePage(),
            },
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorSchemeSeed: theme_Color1,

              // primaryColor: theme_Color1,
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                  centerTitle: true,
                  backgroundColor: theme_Color1,
                  foregroundColor: Colors.white),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorSchemeSeed: theme_Color1,
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                centerTitle: true,
              ),
            ),
            themeMode: Provider.of<ThemeController>(context).getTheme
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: MyRoutes.home,
            routes: {
              MyRoutes.home: (context) => HomePage(),
            },
          );
  }
}

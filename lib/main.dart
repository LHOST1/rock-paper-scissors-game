import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:taskagitmakas/startScreen.dart';

import 'package:taskagitmakas/tasKagitMakas.dart';
import 'package:taskagitmakas/theme_data.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeColorData>(
      create: (BuildContext context) => ThemeColorData(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeColorData>(context).themeColor,
      initialRoute: "/",
      routes: {
        "/": (context) => StartScreen(),
        "/tas": (context) => TasKagitMakas(),
      },
    );
  }
}

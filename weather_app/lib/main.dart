import 'package:flutter/material.dart';
import 'package:weather_app/modules/splash_module/screens/splash_screen.dart';
import 'package:weather_app/themes/themes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VVeatherly',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      home: const SplashScreen() ,
      debugShowCheckedModeBanner: false, 
    );
  }
}




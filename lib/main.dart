import 'package:flutter/material.dart';
import 'package:food_truck_locator/ui/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Truck Locator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Color(0xFFFFFFFF),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: Colors.white),
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontFamily: 'Campton',
                  color: Color(0xFF1B2124),
                  fontSize: 32),
              headline2: TextStyle(
                  fontFamily: 'Campton',
                  color: Color(0xFF1B2124),
                  fontSize: 24),
              bodyText1: TextStyle(
                  fontFamily: 'Campton',
                  color: Color(0xFF1B2124),
                  fontSize: 16),
              bodyText2: TextStyle(
                  fontFamily: 'Campton',
                  color: Color(0xFF1B2124),
                  fontSize: 14))),
      home: const SplashScreen(),
    );
  }
}

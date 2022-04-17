import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_management/provider/small_change_variable_provider.dart';
import 'package:sport_management/screens/home_page.dart';
import 'package:sport_management/screens/login_screen/login_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => SmallValueChangerProvider()),
      ],
      child: MaterialApp(
        title: 'Sport Mangement',
        home: const HomePage(),

        /// LoginPage() or HomePage()
        theme: ThemeData(
            primaryColor: Colors.deepOrangeAccent,
            focusColor: const Color.fromARGB(255, 1, 202, 247),
            textTheme: const TextTheme(
                headline6:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                bodyText1: TextStyle(color: Colors.white, fontSize: 16.0),
                bodyText2: TextStyle(color: Colors.black87, fontSize: 16.0))),
        //routes for test of widgets
        // routes: {},
      ),
    ),
  );
}

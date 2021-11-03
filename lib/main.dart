import 'package:flutter/material.dart';
import 'package:hms/locator.dart';
import 'package:hms/router1.dart';
import 'package:hms/uiAndPages/pagesAndModel/landing/LandingPage.dart';


void main() {

  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      onGenerateRoute: (settings) => Router1.generateRoute(settings),

      home: LandingPageView(),
    );
  }
}

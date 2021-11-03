import 'package:flutter/material.dart';
import 'package:hms/uiAndPages/pagesAndModel/landing/LandingPage.dart';

class Router1{



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(settings:RouteSettings(name: "/"), builder: (_) => LandingPageView());
      // case 'login':
      //   return MaterialPageRoute(builder: (_) => LoginView());
      // case 'post':
      //   var post = settings.arguments as Post;
      //   return MaterialPageRoute(builder: (_) => PostView(post: post,));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
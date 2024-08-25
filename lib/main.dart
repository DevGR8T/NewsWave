import 'package:flutter/material.dart';
import 'package:newswave/pages/allbreaknewspage.dart';
import 'package:newswave/pages/alltrendingnewspage.dart';
import 'package:newswave/pages/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newswave/pages/landingpage.dart';
import 'package:newswave/pages/trendwebviewpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //TRANSTION OF PAGES

  PageRouteBuilder<dynamic> customPageRouteBuilder(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); //Start from right
        const end = Offset.zero; // End at original position
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {
          case '/home':
            page = HomePage();
            break;
          case '/trendwebviewpage':
            //check if arguments are provided and contain a URL
            if (settings.arguments != null && settings.arguments is String) {
              page = TrendWebViewPage(url: settings.arguments as String);
            } else {
              //Fallback to HomePage if no URL is Provided
              page = HomePage();
            }
            break;
          case '/trends':
            page = AllTrendingNews();
            break;
          case '/headnews':
            page = AllBreakingNews();
            break;
          default:
            page = HomePage();
        }
        return customPageRouteBuilder(page);
      },
      theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(),
          primarySwatch: Colors.green),
      home: LandingPage(),
    );
  }
}

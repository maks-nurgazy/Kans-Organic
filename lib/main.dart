import 'package:org_chemistry/Screens/main.dart';
import 'package:org_chemistry/Screens/search.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'Screens/about.dart';
import 'Screens/category.dart';
import 'Screens/videos.dart';
import 'Screens/remarks.dart';

RateMyApp _rateMyApp = RateMyApp();

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // This allows to use async methods in the main method without any problem.

  // _rateMyApp.conditions.add(MaxDialogOpeningCondition(_rateMyApp)); // This one is a little example of a custom condition. See below for more info.
  _rateMyApp.init().then((_) {
    // We initialize our Rate my app instance.
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ОРГАНИКАЛЫК ХИМИЯ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MainScreen(rateMyApp: _rateMyApp),
        '/about': (context) => AboutScreen(),
        '/search': (context) => SearchScreen(),
        '/category': (context) => CategoryScreen(),
        '/videos': (context) => VideosScreen(),
        '/remarks': (context) => RemarksScreen(),
      },
    );
  }
}

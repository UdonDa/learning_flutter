import 'package:flutter/material.dart';
import 'package:appexample/view/home_page/page.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
        accentColor: Colors.cyan[600],

        fontFamily: 'WorkSans',

        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'WorkSans'),
          subtitle2: TextStyle(fontSize: 16.0, fontFamily: 'WorkSans'),
        )

      ),
    );
  }
}

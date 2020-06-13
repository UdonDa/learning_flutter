import 'package:flutter/material.dart';



class PageRouteBuilderDemo extends StatelessWidget {
  static const String routeName = '/basics/page_route_builder';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(32.0),
          ),
          RaisedButton(
            child: Text('From Down!'),
            onPressed: () {
              Navigator.of(context).push<void>(_createRouteFromDown());
            },
            color: Colors.red[200],
          ),
          RaisedButton(
            child: Text('From Top!'),
            onPressed: () {
              Navigator.of(context).push<void>(_createRouteFromTop());
            },
            color: Colors.blue[200],
          ),
          RaisedButton(
            child: Text('From Left!'),
            onPressed: () {
              Navigator.of(context).push<void>(_createRouteFromLeft());
            },
            color: Colors.green[200],
          ),
          RaisedButton(
            child: Text('From Right!'),
            onPressed: () {
              Navigator.of(context).push<void>(_createRouteFromRight());
            },
            color: Colors.yellow[200],
          ),
        ],
        ),
      ),
    );
  }
}

Route _createRouteFromDown() {
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => _Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}


Route _createRouteFromTop() {
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => _Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}

Route _createRouteFromLeft() {
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => _Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}

Route _createRouteFromRight() {
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => _Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}

class _Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Page 2!', style: Theme.of(context).textTheme.headline4),
      ),
    );
  }
}

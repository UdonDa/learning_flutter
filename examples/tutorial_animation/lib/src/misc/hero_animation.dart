import 'package:flutter/material.dart';
// https://qiita.com/r-k-y/items/3428e466d0f908fd7ca4
class HeroAnimationDemo extends StatelessWidget {
  static const String routeName = '/misc/hero_animation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        child: Hero(
          tag: 'hero-page-child',
          child: _createHeroContainer(
              size: 50.0,
              color: Colors.grey[300]
          )
        ),
        onTap: () => Navigator.of(context)
              .push<void>(MaterialPageRoute(builder: (context) => HeroPage())),
      ),
    );
  }
}

class HeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'hero-page-child',
            child: _createHeroContainer(
              size: 100,
              color: Colors.white,
        ),
        ),
      ),
    );
  }
}

StatelessWidget _createHeroContainer({double size, Color color}) {
  return Container(
    height: size,
    width: size,
    padding: EdgeInsets.all(10.0),
    margin: size < 100.0 ? EdgeInsets.all(10.0) : EdgeInsets.all(0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: FlutterLogo(),
  );
}
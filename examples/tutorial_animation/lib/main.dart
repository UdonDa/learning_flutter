import 'package:flutter/material.dart';
import 'package:tutorialanimation/src/basics/animation_controller.dart';
import 'src/basics/animated_container.dart';
import 'src/basics/page_route_builder.dart';
import 'src/basics/tweens.dart';
import 'src/basics/animated_builder.dart';
import 'src/basics/custom_tween.dart';
import 'src/basics/tween_sequence.dart';
import 'src/basics/fade_transition.dart';
import 'src/misc/animated_list.dart';
import 'src/misc/animated_positioned.dart';
import 'src/misc/animated_switcher.dart';
import 'src/misc/card_swipe.dart';
import 'src/misc/carousel.dart';

void main() => runApp(AnimationSamples());

class AnimationSamples extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Samples',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: allRoutes,
      home: HomePage(),
    );
  }
}

final allRoutes = <String, WidgetBuilder> {
  ...basicDemoRoutes,
  ...miscDemoRoutes,
};


final basicDemoRoutes = Map.fromEntries(basicDemos.map((d) => MapEntry(d.route, d.builder)));
final miscDemoRoutes = Map.fromEntries(miscDemos.map((d) => MapEntry(d.route, d.builder)));

final basicDemos = [
  Demo(
    name: 'AnimatedContainer',
    route: AnimatedContainerDemo.routeName,
    builder: (context) => AnimatedContainerDemo()),
  Demo(
    name: 'PageRouteBuilder',
    route: PageRouteBuilderDemo.routeName,
    builder: (context) => PageRouteBuilderDemo()),
  Demo(
    name: 'AnimationController',
    route: AnimationControllerDemo.routeName,
    builder: (context) => AnimationControllerDemo()),
  Demo(
      name: 'Tweens',
      route: TweenDemo.routeName,
      builder: (context) => TweenDemo()),
  Demo(
      name: 'AnimatedBuilder',
      route: AnimatedBuilderDemo.routeName,
      builder: (context) => AnimatedBuilderDemo()),
  Demo(
      name: 'CustomTween',
      route: CustomTweenDemo.routeName,
      builder: (context) => CustomTweenDemo()),
  Demo(
      name: 'TweenSequence',
      route: TweenSequenceDemo.routeName,
      builder: (context) => TweenSequenceDemo()),
  Demo(
      name: 'FadeTransition',
      route: FadeTransitionDemo.routeName,
      builder: (context) => FadeTransitionDemo()),
];

final miscDemos = [
  Demo(
    name: 'AnimatedList',
    route: AnimatedListDemo.routeName,
    builder: (context) => AnimatedListDemo()),
  Demo(
      name: 'AnimatedPositioned',
      route: AnimatedPositionDemo.routeName,
      builder: (context) => AnimatedPositionDemo()),
  Demo(
      name: 'AnimatedSwitcher',
      route: AnimatedSwitcherDemo.routeName,
      builder: (context) => AnimatedSwitcherDemo()),
  Demo(
      name: 'CardSwipe',
      route: CardSwipeDemo.routeName,
      builder: (context) => CardSwipeDemo()),
  Demo(
      name: 'Carousel',
      route: CarouselDemo.routeName,
      builder: (context) => CarouselDemo()),
];

class Demo {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const Demo({this.name, this.route, this.builder});
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Container')),
      body: ListView(
        children: [
          ListTile(title: Text('Basics', style: headerStyle)),
            ...basicDemos.map((d) => DemoTile(d)),
          ListTile(title: Text('Misc', style: headerStyle)),
          ...miscDemos.map((d) => DemoTile(d))
        ],
      ),
    );
  }
}

class DemoTile extends StatelessWidget {
  final Demo demo;

  DemoTile(this.demo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(demo.name),
      onTap: () {
        Navigator.pushNamed(context, demo.route);
      }
    );
  }
}
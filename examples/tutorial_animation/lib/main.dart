import 'package:flutter/material.dart';
import 'package:tutorialanimation/src/basics/animation_controller.dart';
import 'src/basics/animated_container.dart';
import 'src/basics/page_route_builder.dart';

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
};


final basicDemoRoutes = Map.fromEntries(basicDemos.map((d) => MapEntry(d.route, d.builder)));

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
            ...basicDemos.map((d) => DemoTile(d))
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
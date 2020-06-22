import 'package:flutter/material.dart';
import 'src/method_channel_demo.dart';

void main() => runApp(PlatformChannelSample());


class PlatformChannelSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/methodChannelDemo': (context) => MethodChannelDemo()
      },
      title: 'Platform Channel Sample',
      home: HomePage(),
    );
  }
}


class DemoInfo {
  final String demoTitle;
  final String demoRoute;

  DemoInfo(this.demoTitle, this.demoRoute)
      : assert(demoTitle != null),
        assert(demoRoute != null);
}

List<DemoInfo> demoList = [
  DemoInfo(
    'MethodChannel Demo',
    '/methodChannelDemo'
  )
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Platform Channel Sample'),
      ),
      body: ListView(
        children: demoList.map((demoInfo) => DemoTitle(demoInfo)).toList(),
      ),
    );
  }
}

class DemoTitle extends StatelessWidget {
  final DemoInfo demoInfo;
  DemoTitle(this.demoInfo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(demoInfo.demoTitle),
      onTap: () => Navigator.pushNamed(context, demoInfo.demoRoute),
    );
  }
}
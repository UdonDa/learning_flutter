import 'package:flutter/material.dart';

import 'performance_page.dart';
import 'infinite_process_page.dart';
import 'data_transfer_page.dart';


void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.flash_on),
                  text: 'Performance',
                ),
                Tab(
                  icon: Icon(Icons.sync),
                  text: 'Infinite Process',
                ),
                Tab(
                  icon: Icon(Icons.storage),
                  text: 'Data Transfer',
                )
              ],
            ),
            title: Text('Isolate Example'),
          ),
          body: TabBarView(
            children: [
              PerformancePage(),
              InfiniteProcessPageStarter(),
              DataTransferPageStarter()
            ],
          ),
        ),
      )
    );
  }
}
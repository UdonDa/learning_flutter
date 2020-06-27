import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformdesign/tabs/widgets.dart';

import 'tabs/songs_tab.dart';
import 'tabs/news_tab.dart';
import 'tabs/profile_tab.dart';
import 'tabs/settings_tab.dart';

void main() => runApp(MyAdaptingApp());


class MyAdaptingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Music App',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      darkTheme: ThemeData.dark(),
      builder: (context, child) {
        return CupertinoTheme(
          data: CupertinoThemeData(),
          child: Material(child: child),
        );
      },
      home: PlatformAdaptiveHomePage(),
    );
  }
}


class PlatformAdaptiveHomePage extends StatefulWidget {
  @override
  _PlatformAdaptiveHomePageState createState() => _PlatformAdaptiveHomePageState();
}

class _PlatformAdaptiveHomePageState extends State<PlatformAdaptiveHomePage> {

  final songsTabKey = GlobalKey();

  Widget _buildAndroidHomePage(BuildContext context) {
    return SongsTab(
      key: songsTabKey,
      androidDrawer: _AndroidDrawer(),
    );
  }

  Widget _buildIosHomePage(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(title: Text(SongsTab.title), icon: SongsTab.iosIcon),
          BottomNavigationBarItem(title: Text(NewsTab.title), icon: NewsTab.iosIcon),
          BottomNavigationBarItem(title: Text(ProfileTab.title), icon: ProfileTab.iosIcon),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              defaultTitle: SongsTab.title,
              builder: (context) => SongsTab(key: songsTabKey),
            );
          case 1:
            return CupertinoTabView(
              defaultTitle: NewsTab.title,
              builder: (context) => NewsTab(),
            );
          case 2:
            return CupertinoTabView(
              defaultTitle: ProfileTab.title,
              builder: (context) => ProfileTab(),
            );
          default:
            assert(false, 'Unexpected tab');
            return null;
        }
      },
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroidHomePage,
      iosBuilder: _buildIosHomePage
    );
  }
}

class _AndroidDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Icon(
                Icons.account_circle,
                color: Colors.green.shade800,
                size: 96,
              ),
            ),
          ),
          ListTile(
            leading: SongsTab.androidIcon,
            title: Text(SongsTab.title),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: NewsTab.androidIcon,
            title: Text(NewsTab.title),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: ProfileTab.androidIcon,
            title: Text(ProfileTab.title),
            onTap: () => Navigator.pop(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          ListTile(
            leading: SettingsTab.androidIcon,
            title: Text(SettingsTab.title),
            onTap: () {
              Navigator.pop(context);
              Navigator.push<void>(context, MaterialPageRoute(builder: (context) => SettingsTab()));
            },
          )
        ],
      ),
    );
  }
}
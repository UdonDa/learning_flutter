import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'settings_tab.dart';
import 'widgets.dart';
import 'preference_card.dart';


class ProfileTab extends StatelessWidget {
  static const title = 'Profile';
  static const androidIcon = Icon(Icons.person);
  static const iosIcon = Icon(CupertinoIcons.profile_circled);

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text('😼', style: TextStyle(fontSize: 80, decoration: TextDecoration.none),),
              ),
            ),
            PreferenceCard(
              header: 'MY INTENSITY PREFERENCE',
              content: '🔥',
              preferenceChoices: [
                'Super heavy',
                'Dial it to 11',
                "Head bangin'",
                '1000W',
                'My neighbor hates me',
              ],
            ),
            PreferenceCard(
              header: 'CURRENT MOOD',
              content: '🤘🏾🚀',
              preferenceChoices: [
                'Over the moon',
                'Basking in sunlight',
                'Hello fellow Martians',
                'Into the darkness',
              ],
            ),
            Expanded(
              child: Container(),
            ),
            LogOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: _buildBody(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: SettingsTab.iosIcon,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push<void>(
              CupertinoPageRoute(
                title: SettingsTab.title,
                fullscreenDialog: true,
                builder: (context) => SettingsTab(),
              )
            );
          },
        ),
      ),
      child: _buildBody(context),
    );
  }


  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

class LogOutButton extends StatelessWidget {
  static const _logoutMessage = Text('No!');
  
  Widget _buildAndroid(BuildContext context) {
    return RaisedButton(
      child: Text('LOG OUT', style: TextStyle(color: Colors.red),),
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Log out?'),
              content: _logoutMessage,
              actions: [
                FlatButton(
                  child: const Text('Yes'),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: const Text('No'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          }
        );
      },
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoButton(
      color: CupertinoColors.destructiveRed,
      child: Text('Log out'),
      onPressed: () {
        showCupertinoModalPopup(context: context, builder: (context) {
          return CupertinoActionSheet(
            title: Text('Log out?'),
            message: _logoutMessage,
            actions: [
              CupertinoActionSheetAction(
                child: const Text('Reprogram the night man'),
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoActionSheetAction(
                child: const Text('Yes'),
                onPressed: () => Navigator.pop(context),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text('No'),
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

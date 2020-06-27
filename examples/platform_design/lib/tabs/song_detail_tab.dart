import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';

class SongsDetailTab extends StatelessWidget {
  const SongsDetailTab({this.id, this.song, this.color});

  final int id;
  final String song;
  final Color color;

  Widget _buildBody() {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: id,
            child: HeroAnimatingSongCard(
              song: song,
              color: color,
              heroAnimation: AlwaysStoppedAnimation(1),
            ),
            flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) {
              return HeroAnimatingSongCard(
                song: song,
                color: color,
                heroAnimation: animation,
              );
            },
          ),
          Divider(
            height: 0,
            color: Colors.grey[200],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, top: 16, bottom: 8),
                    child: Text(
                      'You might also like',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  );
                }
                return SongPlaceholderTile();
              }
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(song),),
      body: _buildBody(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(song),
        previousPageTitle: 'Songs',
      ),
      child: _buildBody(),
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
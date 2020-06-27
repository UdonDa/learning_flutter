import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:platformdesign/tabs/utils.dart';
import 'package:platformdesign/tabs/widgets.dart';

import 'song_detail_tab.dart';

class SongsTab extends StatefulWidget {
  static const title = 'Songs';
  static const androidIcon = Icon(Icons.music_note);
  static const iosIcon = Icon(CupertinoIcons.music_note);

  const SongsTab({Key key, this.androidDrawer}) : super(key: key);

  final Widget androidDrawer;

  @override
  _SongsTabState createState() => _SongsTabState();
}

class _SongsTabState extends State<SongsTab> {
  static const _itemsLength = 50;

  final _androidRefreshKey = GlobalKey<RefreshIndicatorState>();

  List<MaterialColor> colors;
  List<String> songNames;

  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() {
    colors = getRandomColors(_itemsLength);
    songNames = getRandomNames(_itemsLength);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshData() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => setState(() => _setData())
    );
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return null;

    final color = defaultTargetPlatform == TargetPlatform.iOS ? colors[index] : colors[index].shade400;

    return SafeArea(
      top: false,
      bottom: false,
      child: Hero(
        tag: index,
        child: HeroAnimatingSongCard(
          song: songNames[index],
          color: color,
          heroAnimation: AlwaysStoppedAnimation(0),
          onPressed: () => Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (context) => SongsDetailTab(
                id: index,
                song: songNames[index],
                color: color,
              )
            )
          ),
        ),
      ),
    );
  }

  void _togglePlatform() {
    TargetPlatform _getOppositePlatform() {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return TargetPlatform.android;
      } else {
        return TargetPlatform.iOS;
      }
    }
    debugDefaultTargetPlatformOverride = _getOppositePlatform();
    WidgetsBinding.instance.reassembleApplication();
  }


  Widget _buildeAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SongsTab.title),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async => await _androidRefreshKey.currentState.show(),
          ),
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: _togglePlatform,
          )
        ],
      ),
      drawer: widget.androidDrawer,
      body: RefreshIndicator(
        key: _androidRefreshKey,
        onRefresh: _refreshData,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemBuilder: _listBuilder,
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.shuffle),
            onPressed: _togglePlatform,
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: _refreshData,
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(_listBuilder),
            ),
          )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildeAndroid,
      iosBuilder: _buildIos,
    );
  }
}



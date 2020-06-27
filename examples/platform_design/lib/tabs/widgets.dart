import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class PlatformWidget extends StatelessWidget {
  const PlatformWidget({
    Key key,
    @required this.androidBuilder,
    @required this.iosBuilder,
  }) : assert(androidBuilder != null),
       assert(iosBuilder != null),
       super(key: key);

  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder(context);
      case TargetPlatform.iOS:
        return iosBuilder(context);
      default:
        assert(false, 'Unexpexted platform $defaultTargetPlatform');
        return null;
    }
  }
}


class PressableCard extends StatefulWidget {
  const PressableCard({
    this.onPressed,
    this.color,
    this.flattenAnimation,
    this.child
  });

  final VoidCallback onPressed;
  final Color color;
  final Animation<double> flattenAnimation;
  final Widget child;

  @override
  _PressableCardState createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard> with SingleTickerProviderStateMixin {
  bool pressed = false;
  AnimationController controller;
  Animation<double> animation;
  Duration duration = const Duration(milliseconds: 40);

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: duration);
    animation = controller.drive(CurveTween(curve: Curves.easeInOutCubic));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double get flatten => 1 - widget.flattenAnimation.value;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        if (widget.onPressed != null) {
          controller.forward();
        }
      },
      onPointerUp: (details) {
        controller.reverse();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (widget.onPressed != null) {
            widget.onPressed();
          }
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([animation, widget.flattenAnimation]),
          child: widget.child,
          builder: (context, child) {
            return Transform.scale(
                scale: 1 - animation.value * 0.03,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16) * flatten,
                  child: PhysicalModel(
                    elevation: ((1 - animation.value) * 10 + 10) * flatten,
                    clipBehavior: Clip.antiAlias,
                    color: widget.color,
                    child: child,
                  ),
                ),
            );
          },
        ),
      ),
    );
  }
}


class HeroAnimatingSongCard extends StatelessWidget {
  HeroAnimatingSongCard({
    this.song,
    this.color,
    this.heroAnimation,
    this.onPressed
  });

  final String song;
  final Color color;
  final Animation<double> heroAnimation;
  final VoidCallback onPressed;

  double get playButtonSize => 50 + 50 * heroAnimation.value;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: heroAnimation,
      builder: (context, child) {
        return PressableCard(
          onPressed: heroAnimation.value == 0 ? onPressed : null,
          color: color,
          flattenAnimation: heroAnimation,
          child: SizedBox(
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: -80 * heroAnimation.value,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    color: Colors.black12,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      song,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 45) * (1 - heroAnimation.value),
                  child: Container(
                    height: playButtonSize,
                    width: playButtonSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black12
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.play_arrow,
                      size: playButtonSize,
                      color: Colors.black38,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SongPlaceholderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          children: [
            Container(
              color: Theme.of(context).textTheme.bodyText2.color,
              width: 130,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 9,
                    margin: const EdgeInsets.only(right: 60),
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                  Container(
                    height: 9,
                    margin: const EdgeInsets.only(right: 20, top: 8),
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                  Container(
                    height: 9,
                    margin: const EdgeInsets.only(right: 40, top: 8),
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                  Container(
                    height: 9,
                    margin: const EdgeInsets.only(right: 80, top: 8),
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                  Container(
                    height: 9,
                    margin: const EdgeInsets.only(right: 50, top: 8),
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


/// On Android, it uses a dialog with radio buttons. On iOS, it uses a picker.
void showChoices(BuildContext context, List<String> choices) {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      showDialog<void>(
        context: context,
        builder: (context) {
          var selectedRatio = 1;
          return AlertDialog(
            contentPadding: const EdgeInsets.only(top: 12),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List<Widget>.generate(choices.length, (index) {
                    return RadioListTile(
                      title: Text(choices[index]),
                      value: index,
                      groupValue: selectedRatio,
                      onChanged: (int value) => setState(() => selectedRatio = value)
                    );
                  })
                );
              },
            ),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        }
      );
      return;
    case TargetPlatform.iOS:
      showCupertinoModalPopup<void>(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 250,
            child: CupertinoPicker(
              backgroundColor: Theme.of(context).canvasColor,
              useMagnifier: true,
              magnification: 1.1,
              itemExtent: 40,
              scrollController: FixedExtentScrollController(initialItem: 1),
              children: List<Widget>.generate(choices.length, (index) {
                return Center(
                  child: Text(
                    choices[index],
                    style: TextStyle(fontSize: 21),
                  ),
                );
              }),
              onSelectedItemChanged: (value) {},
            ),
          );
        }
      );
      return;
    default:
      assert(false, 'Unexpected platform $defaultTargetPlatform');
  }
}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';


class CardSwipeDemo extends StatefulWidget {
  static String routeName = '/misc/card_swipe';

  @override
  _CardSwipeDemoState createState() => _CardSwipeDemoState();
}

class _CardSwipeDemoState extends State<CardSwipeDemo>
  with SingleTickerProviderStateMixin {

  List<String> fileNames;

  @override
  void initState() {
    super.initState();
    _resetCards();
  }

  void _resetCards() {
    fileNames = [
      'assets/eat_cape_town_sm.jpg',
      'assets/eat_new_orleans_sm.jpg',
      'assets/eat_sydney_sm.jpg',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Swipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRect(
                  child: Stack(
                    overflow: Overflow.clip,
                    children: <Widget>[
                      for (final fileName in fileNames)
                        SwipeableCard(
                          imageAssetName: fileName,
                          onSwiped: () {
                            setState(() {
                              fileNames.remove(fileName);
                            });
                          }
                        )
                    ],
                  ),
                ),
              ),
              RaisedButton(
                child: const Text('Refill'),
                onPressed: () => _resetCards(),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Card extends StatelessWidget {
  final String imageAssetName;

  Card(this.imageAssetName);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
              image: AssetImage(imageAssetName),
              fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}

class SwipeableCard extends StatefulWidget {
  final String imageAssetName;
  final VoidCallback onSwiped;

  SwipeableCard({this.imageAssetName, this.onSwiped});

  @override
  _SwipeableCardState createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;
  double dragStartX;
  bool isSwipingLeft = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController.unbounded(vsync: this);
    animation = controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1, 0)
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: GestureDetector(
        onHorizontalDragStart: dragStart,
        onHorizontalDragUpdate: dragUpdate,
        onHorizontalDragEnd: dragEnd,
        child: Card(widget.imageAssetName),
      ),
    );
  }

  void dragStart(DragStartDetails details) {
    dragStartX = details.localPosition.dx;
  }

  void dragUpdate(DragUpdateDetails details) {
    var _isSwipingLeft = (details.localPosition.dx - dragStartX) < 0;
    if (_isSwipingLeft != isSwipingLeft) {
      isSwipingLeft = _isSwipingLeft;
      updateAnimation(details.localPosition.dx);
    }

    setState(() {
      controller.value = (details.localPosition.dx - dragStartX).abs() / context.size.width;
    });
  }

  void dragEnd(DragEndDetails details) {
    var velocity = (details.velocity.pixelsPerSecond.dx / context.size.width).abs();
    animate(velocity: velocity);
  }

  void updateAnimation(double dragPosition) {
    animation = controller.drive(Tween<Offset>(
      begin: Offset.zero,
      end: isSwipingLeft ? Offset(-1, 0) : Offset(1, 0),
    ));
  }

  void animate({double velocity = 0}) {
    var description = SpringDescription(mass: 50, stiffness: 1, damping: 1);
    var simulation = SpringSimulation(description, controller.value, 1, velocity);
    controller.animateWith(simulation).then<void>((_) => widget.onSwiped());
  }
}
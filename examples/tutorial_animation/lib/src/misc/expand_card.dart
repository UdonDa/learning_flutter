import 'package:flutter/material.dart';

class ExpandCardDemo extends StatelessWidget {
  static const String routeName = '/misc/expand_card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ExpandCard(),
      ),
    );
  }
}

class ExpandCard extends StatefulWidget {
  @override
  _ExpandCardState createState() => _ExpandCardState();
}


Widget generateCardContainer(Duration duration, double size, bool selected, String image_path) => Card(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: AnimatedContainer(
      duration: duration,
      width: size,
      height: size,
      curve: Curves.ease,
      child: AnimatedCrossFade(
        duration: duration,
        firstCurve: Curves.easeInOutCubic,
        secondCurve: Curves.easeInOutCubic,
        crossFadeState: selected
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
          return Stack(
            children: [
              Positioned.fill(
                key: bottomChildKey,
                child: bottomChild,
              ),
              Positioned.fill(
                key: topChildKey,
                child: topChild,
              ),
            ],
          );
        },
        firstChild: Image.asset(
          image_path,
          fit: BoxFit.cover,
        ),
        secondChild: Image.asset(
//                'assets/eat_new_orleans_sm.jpg',
            image_path,
            fit: BoxFit.cover
        ),
      ),
    ),
  ),
);


class _ExpandCardState extends State<ExpandCard> with TickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 300);
  bool _selected_1 = false;
  bool _selected_2 = false;
  bool _selected_3 = false;
  double get _size_1 => _selected_1 ? 256 : 128;
  double get _size_2 => _selected_2 ? 256 : 128;
  double get _size_3 => _selected_3 ? 256 : 128;

  void toggleExpanded_1() {
    setState(() {
      _selected_1 = !_selected_1;
    });
  }

  void toggleExpanded_2() {
    setState(() {
      _selected_2 = !_selected_2;
    });
  }

  void toggleExpanded_3() {
    setState(() {
      _selected_3 = !_selected_3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GestureDetector(
        onTap: () => toggleExpanded_1(),
        child: generateCardContainer(_duration, _size_1, _selected_1, 'assets/eat_new_orleans_sm.jpg'),
        ),
        GestureDetector(
          onTap: () => toggleExpanded_2(),
          child: generateCardContainer(_duration, _size_2, _selected_2, 'assets/eat_new_orleans_sm.jpg'),
        ),
        GestureDetector(
          onTap: () => toggleExpanded_3(),
          child: generateCardContainer(_duration, _size_3, _selected_3, 'assets/eat_new_orleans_sm.jpg'),
        ),
      ],
    );


  }



}
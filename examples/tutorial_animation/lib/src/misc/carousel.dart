import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CarouselDemo extends StatelessWidget {
  static String routeName = '/misc/carousel';

  static const List<String> fileNames = [
    'assets/eat_cape_town_sm.jpg',
    'assets/eat_new_orleans_sm.jpg',
    'assets/eat_sydney_sm.jpg',
  ];

  final List<Widget> images =
      fileNames.map((file) => Image.asset(file, fit: BoxFit.cover)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carousel Demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AspectRatio(
            aspectRatio: 1,
            child: Carousel(itemBuilder: widgetBuilder),
          ),
        ),
      ),
    );
  }

  Widget widgetBuilder(BuildContext context, int index) {
    return images[index % images.length];
  }
}

typedef OnCurrentItemChangedCallback = void Function(int currentItem);

class Carousel extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  const Carousel({Key key, @required this.itemBuilder});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController controller;
  int currentPage;
  bool pageHasChanged = false;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    controller = PageController(
      viewportFraction: .85,
      initialPage: currentPage
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PageView.builder(
        onPageChanged: (value) {
          setState(() {
            pageHasChanged = true;
            currentPage = value;
          });
        },
        controller: controller,
        itemBuilder: (context, index) => AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            var result = pageHasChanged ? controller.page : currentPage * 1.0;
            var value = result - index;
            value = (1 - (value.abs() * .5)).clamp(0.0, 1.0) as double;

            return Center(
              child: SizedBox(
                height: Curves.easeOut.transform(value) * size.height,
                width: Curves.easeOut.transform(value) * size.width,
                child: child,
              ),
            );
          },
          child: widget.itemBuilder(context, index),
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

int fib(int n) {
  var a = n - 1;
  var b = n - 2;

  if (n == 1) {
    return 0;
  } else if (n == 0) {
    return 1;
  } else {
    return (fib(a) + fib(b));
  }
}

class PerformancePage extends StatefulWidget {
  @override
  _PerformancePageState createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  Future<void> computeFuture = Future.value();

  void handleComputeOnMain(BuildContext context) {
    var future = computeOnMainIsolate()
        ..then((_) {
          var snackBar = SnackBar(
            content: Text('Main Isolate Done!'),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        });

    setState(() {
      computeFuture = future;
    });
  }

  void handleComputeOnSecondary(BuildContext context) {
    var future = computeOnSecondaryIsolate()
        ..then((_) {
          var snackBar = SnackBar(
            content: Text('Secondary Isolate Done!'),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        });

    setState(() {
      computeFuture = future;
    });
  }

  Future<void> computeOnMainIsolate() async {
    await Future<void>.delayed(Duration(milliseconds: 300));
    fib(45);
  }

  Future<void> computeOnSecondaryIsolate() async {
    await compute(fib, 45);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmoothAnimationWidget(),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  FutureBuilder(
                    future: computeFuture,
                    builder: (context, snapshot) {
                      return RaisedButton(
                        child: const Text('Compute on Main'),
                        elevation: 8.0,
                        onPressed:
                          snapshot.connectionState == ConnectionState.done
                              ? () => handleComputeOnMain(context)
                              : null,
                      );
                    }
                  ),
                  FutureBuilder(
                      future: computeFuture,
                      builder: (context, snapshot) {
                        return RaisedButton(
                          child: const Text('Compute on Secondary'),
                          elevation: 8.0,
                          onPressed:
                          snapshot.connectionState == ConnectionState.done
                              ? () => handleComputeOnSecondary(context)
                              : null,
                        );
                      }
                  ),
                ],
              ),
            )
          ],
      )
    );
  }
}

class SmoothAnimationWidget extends StatefulWidget {
  @override
  _SmoothAnimationWidgetState createState() => _SmoothAnimationWidgetState();
}

class _SmoothAnimationWidgetState extends State<SmoothAnimationWidget> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<BorderRadius> _borderAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _borderAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(100.0),
      end: BorderRadius.circular(0.0)
    ).animate(_animationController);

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _borderAnimation,
        builder: (context, child) {
          return Container(
            child: FlutterLogo(size: 200,),
            alignment: Alignment.bottomCenter,
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Colors.blueAccent,
                  Colors.redAccent,
                ],
              ),
              borderRadius: _borderAnimation.value,
            ),
          );
        }
      ),
    );
  }
}
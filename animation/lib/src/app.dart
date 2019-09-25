import 'package:animation/src/widgets/cat_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:flutter/animation.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController animationController;

  Animation<double> flapAnimation;
  AnimationController flapAnimationContoller;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    flapAnimationContoller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    catAnimation = Tween(
      begin: -35.0,
      end: -80.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: animationController,
      ),
    );

    flapAnimation = Tween(
      begin: Math.pi * .6,
      end: Math.pi * .7,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: flapAnimationContoller,
      ),
    );

    flapMovement();
  }

  flapMovement() {
    flapAnimationContoller.forward();

    flapAnimationContoller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        flapAnimationContoller.forward();
      } else if (status == AnimationStatus.completed) {
        flapAnimationContoller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation app',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Animation app"),
        ),
        body: InkWell(
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                buildAnimtedImage(),
                buildBox(),
                buildLeftFlap(),
              ],
            ),
          ),
          onTap: _onTap,
        ),
      ),
    );
  }

  Widget buildAnimtedImage() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (BuildContext context, Widget child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          left: 0.0,
          right: 0.0,
        );
      },
      child: CatImage(),
    );
  }

  void _onTap() {
    if (animationController.status == AnimationStatus.dismissed ||
        animationController.status == AnimationStatus.reverse) {
      flapAnimationContoller.reset();
      flapAnimationContoller.stop();

      animationController.forward();
    } else if (animationController.status == AnimationStatus.completed ||
        animationController.status == AnimationStatus.forward) {
      animationController.reverse();
      flapAnimationContoller.forward();
    }
  }

  Widget buildBox() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.grey,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      child: AnimatedBuilder(
        child: Container(
          width: 125,
          height: 10,
          color: Colors.grey,
        ),
        animation: flapAnimation,
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            child: child,
            angle: flapAnimation.value,
            alignment: Alignment.topLeft,
          );
        },
      ),
      left: 4.0,
    );
  }
}

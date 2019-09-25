import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class CatAnimation extends StatefulWidget {
  @override
  _CatAnimationState createState() => _CatAnimationState();
}

class _CatAnimationState extends State<CatAnimation>
    with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController animationController;
  Animation<double> flapAnimation;
  AnimationController flapAnimationController;

  @override
  void initState() {
    super.initState();

    flapAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    flapAnimation = Tween(
      begin: 0.0,
      end: 3.140,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: flapAnimationController,
      ),
    );

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    catAnimation = Tween(
      // begin: 0.0,
      // begin: -50.0,
      begin: -35.0,
      // end: 100.0,
      end: -90.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: animationController,
      ),
    );
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
          child: Stack(
            // overflow: Overflow.visible,
            children: <Widget>[
              buildAnimtedImage(),
              buildBox(),
              buildLeftFlap()
            ],
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
        // return Container(
        //   child: child,
        //   margin: EdgeInsets.only(top: catAnimation.value),
        // );

        return Positioned(
          child: child,
          top: catAnimation.value,
          // top: catAnimation.value,

          right: 0.0,
          left: 0.0,
        );
      },
      child: CatImage(),
    );
  }

  void _onTap() {
    if (animationController.status == AnimationStatus.dismissed ||
        animationController.status == AnimationStatus.reverse) {
      animationController.forward();
    } else if (animationController.status == AnimationStatus.completed ||
        animationController.status == AnimationStatus.forward) {
      animationController.reverse();
    }
  }

  Widget buildBox() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.grey,
    );
  }

  // Widget buildLeftFlap() {
  //   return Positioned(
  //     left: 3.0,
  //     child: Transform.rotate(
  //       child: Container(
  //         height: 10,
  //         width: 125,
  //         color: Colors.red,
  //       ),
  //       angle: (3.14 / 2) * .6,
  //       alignment: Alignment.topLeft,
  //     ),
  //   );
  // }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        child: Container(
          height: 10,
          width: 125,
          color: Colors.red,
        ),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            child: Container(
              height: 10,
              width: 125,
              color: Colors.red,
            ),
            angle: flapAnimation.value,
            alignment: Alignment.topLeft,
          );
        },
        animation: flapAnimation,
      ),
    );
  }
}

class CatImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network("https://i.imgur.com/QwhZRyL.png");
  }
}

///on the main dart file import import 'package:flutter/rendering.dart'
///and on the void main function set debugPaintSizeEnabled=true

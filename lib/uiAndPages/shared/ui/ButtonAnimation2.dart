import 'dart:math';

import 'package:flutter/material.dart';


class ButtonAnimation2 extends StatefulWidget {

  final Widget child;
  final Function()? onTap;

  const ButtonAnimation2({Key? key, this.onTap, required this.child,}) : super(key: key);

  @override
  _ButtonAnimation2State createState() => _ButtonAnimation2State();
}

class _ButtonAnimation2State extends State<ButtonAnimation2> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400), value: 1);

    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animationController,
          curve: CustomCurve(),
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ScaleTransition(
      scale: animation,

      child: GestureDetector(
        onTap: (){
          animationController.reset();
          animationController.forward();
          widget.onTap?.call();
        },
        child: widget.child,
      ),
    );

  }
}

class CustomCurve extends Curve{
  @override
  double transformInternal(double t) {

    return .1 * sin(pi*t) + 1;
  }
}
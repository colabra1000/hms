import 'dart:math';

import 'package:flutter/material.dart';


class ButtonAnimator2 extends StatefulWidget {

  final Widget child;
  final Function()? onTap;
  final Function()? onTap2;

  const ButtonAnimator2({Key? key, this.onTap, this.onTap2, required this.child,}) : super(key: key);

  @override
  _ButtonAnimator2State createState() => _ButtonAnimator2State();
}

class _ButtonAnimator2State extends State<ButtonAnimator2> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400), value: 1);

    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animationController,
          curve: CustomCurve(),
        ));

    animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        widget.onTap2?.call();
      }
    });

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
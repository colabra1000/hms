import 'package:flutter/material.dart';


class ButtonAnimator1 extends StatefulWidget {
  //action immediately when button is pressed.
  final Function()? onTap;

  //action when button is pressed and animation is finished.
  final Function()? onTap2;

  final Widget child;
  const ButtonAnimator1({Key? key, required this.child, this.onTap2, this.onTap,}) : super(key: key);

  @override
  _ButtonAnimator1State createState() => _ButtonAnimator1State();
}

class _ButtonAnimator1State extends State<ButtonAnimator1> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation<Offset> animation;

  @override
  void dispose() {
      animationController.dispose();
     super.dispose();
  }

  @override
  void initState() {

    Duration halfDuration = Duration(milliseconds: 200);

    animationController = AnimationController(vsync: this, duration: halfDuration);

    animation = Tween<Offset>(begin: Offset(0,0), end: Offset(.05, 0)).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeOut));

    animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        animationController.animateBack(0, duration: halfDuration, curve: Curves.easeOut);
        // animationController.reverse();
      }

      if(status == AnimationStatus.dismissed){
        widget.onTap2?.call();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
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



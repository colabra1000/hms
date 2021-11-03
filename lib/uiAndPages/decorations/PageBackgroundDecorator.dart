import 'package:flutter/material.dart';

class PageBackGroundDecorator extends StatelessWidget {

  final Widget child;

  const PageBackGroundDecorator({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(

                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Colors.green.shade100,
                      Colors.blue.shade100,
                      Colors.purple.shade100
                    ]
                )
            ),
        ),

        child,

      ],

    );
  }
}

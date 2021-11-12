import 'package:flutter/material.dart';
import 'dart:math' as math;


class MyPaint extends StatelessWidget {

  final double totalQuantity;
  final double quantity1;
  final double quantity2;
  final double quantity3;
  final double range;
  final double strokeWidth;
  final Color? color1;
  final Color? color2;
  final Color? color3;

  const MyPaint({
    Key? key,
    required this.totalQuantity,
    required this.quantity1,
    required this.quantity2,
    required this.quantity3,
    this.color1,
    this.color2,
    this.color3,
    this.strokeWidth: 7,
    this.range:1,
  }): super(key: key);



  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: CircleStuff(
            totalQuantity: totalQuantity,
            quantity1: quantity1,
            quantity2: quantity2,
            quantity3: quantity3,
            color1: color1,
            color2: color2,
            color3: color3,

            range: range),
      ),
    );
  }
}


class CircleStuff extends CustomPainter{

  final double totalQuantity;
  final double quantity1;
  final double quantity2;
  final double quantity3;
  final double range;
  final double strokeWidth;
  final Color? color1;
  final Color? color2;
  final Color? color3;



  CircleStuff({
    required this.totalQuantity,
    required this.quantity1,
    required this.quantity2,
    required this.quantity3,
    this.color1,
    this.color2,
    this.color3,
    this.strokeWidth: 7,
    this.range:1,
  });

  double pi = math.pi;

  @override
  void paint(Canvas canvas, Size size) {

    // double remainingQuantity = totalQuantity - (quantity1 + quantity2 + quantity3);

    double height = size.height == 0 ? size.width : size.width == 0 ? size.height : math.min(size.height, size.width);
    double strokeWidth = 15;

    height -= strokeWidth;

    Paint paint1 = Paint()
        ..color = color1 ?? Colors.blue
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;

    Paint paint2 = Paint()
      ..color = color2 ?? Colors.yellow
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Paint paint3 = Paint()
      ..color = color3 ?? Colors.red
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Paint paint4 = Paint()
      ..color = Colors.grey.withOpacity(.3)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;



    Offset center = Offset((height + strokeWidth)/2, (height + strokeWidth)/2);
    Rect rect = Rect.fromCenter(center: center, width: height, height: height,);

    // toRadian((0)) = 0.
    double qty1_start = 0;
    double qty1_end = toRadian(normalise(value: quantity1, max: totalQuantity) * 360 * range);

    double qty2_start = qty1_start + qty1_end;
    double qty2_end = toRadian(normalise(value: quantity2, max: totalQuantity) * 360 * range);

    double qty3_start = qty2_start + qty2_end;
    double qty3_end = toRadian(normalise(value: quantity3, max: totalQuantity) * 360 * range);

    double qtyR_start = qty3_start + qty3_end;
    // toRadian(360) = 2*pi.
    double qtyR_end = 2*pi - qtyR_start;


    canvas.drawArc(rect, qty1_start, qty1_end, false, paint1);
    canvas.drawArc(rect, qty2_start, qty2_end, false, paint2);
    canvas.drawArc(rect, qty3_start, qty3_end, false, paint3);
    canvas.drawArc(rect, qtyR_start, qtyR_end, false, paint4);

  }



  double normalise({required double value, required double max}){
    return value / max;
  }

  double toRadian(double degree){
    return degree * (pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }



}

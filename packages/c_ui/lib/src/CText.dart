import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CText extends StatelessWidget {

  final String text;

  final double size;

  final FontWeight fontWeight;

  final TextAlign alignment;

  final Color? color;

  final EdgeInsets padding;

  final bool? underline;

  final TextOverflow overflow;

  final bool? required;

  final Color? asterixColor;

  final int? maxLine;

  final TextStyle? textStyle;

  final String? fontFamily;

  final FontStyle? fontStyle;

  final TextStyle? _textStyle;
  final TextStyle? _asterixTextStyle;

  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;


  CText(this.text, {this.fontStyle, this.fontFamily, this.height, this.letterSpacing, this.wordSpacing, this.textStyle, this.asterixColor, this.required:false, this.size:20, this.overflow:TextOverflow.visible, this.fontWeight = FontWeight.normal, this.alignment:TextAlign.center, this.color, this.padding:const EdgeInsets.all(3), this.underline = false, this.maxLine, }):


   _textStyle= textStyle ?? TextStyle(fontSize: size, color: color ?? Colors.grey[800],
                 fontWeight: fontWeight,
                  height: height,
                  letterSpacing: letterSpacing ,
                  wordSpacing: wordSpacing,
                  decoration: underline == true ? TextDecoration.underline : TextDecoration.none,
                  fontFamily: fontFamily ?? "Quicksand",
                  fontStyle: fontStyle,),

  _asterixTextStyle = TextStyle(fontSize: size + 2, color: asterixColor ?? Colors.red,
  fontWeight: fontWeight, decoration: underline == true ? TextDecoration.underline : TextDecoration.none,
    fontStyle: fontStyle
  );


  @override
  Widget build(BuildContext context) {

     return Padding(
      padding: padding,
      child: RichText(
        maxLines: maxLine,
          overflow: overflow,
          text:  TextSpan(
            text: text,
            style: _textStyle,


            children: [
              TextSpan(
                text: required == true ? "* " : "",
                style: _asterixTextStyle,
              )
            ],

          )

      ),
    );
  }
}





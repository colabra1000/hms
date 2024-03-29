import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CInputController.dart';


dynamic _emailValidation(value){
  String pattern =
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
  RegExp regex = new RegExp(pattern);


  if(!regex.hasMatch(value)){
    return "Not a valid email";
  }

  return null;
}



class CTextField extends StatefulWidget {

  final String? hintText;
  final int? minLines;
  final CInputController _cInputController;
  final bool isPassword;

  final bool isEmail;

  final bool digitsOnly;
  final bool readOnly;
  final bool enabled;

  final bool shouldNotUpdateText;

  final double? radius;
  final Color? borderColor;
  final double? borderWidth;

  final int? maxLength;
  final Color? hintColor;
  final FocusNode? focusNode;
  final bool? showCursor;
  final TextStyle? textStyle;
  final GlobalKey<FormState>? mKey;
  final bool doNotValidate;
  final InputDecoration? inputDecoration;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final double? fontSize;
  final EdgeInsets? contentPadding;





  CTextField(this._cInputController, {this.prefixIcon, this.suffixIcon, this.contentPadding, this.fontSize, this.inputDecoration, this.doNotValidate:false, this.mKey, this.focusNode, this.hintColor, this.maxLength, this.borderWidth, this.borderColor, this.radius, this.enabled:true, this.readOnly:false, this.digitsOnly:false, this.hintText:"", this.minLines:1, this.isPassword:false, this.isEmail:false, this.showCursor, this.textStyle, this.shouldNotUpdateText:false}):
  assert((inputDecoration != null && radius == null && borderColor == null && borderWidth == null
  && prefixIcon == null && suffixIcon == null)
      || inputDecoration == null),
  assert((textStyle != null && fontSize == null) || textStyle == null);


  @override
  _CTextFieldState createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {

  final defaultBorderColor = Colors.green[500]!;

  final double defaultRadius = 5;

  final double defaultBorderWidth = 1;

  final Color defaultHintColor = Colors.grey[400]!;

  late final TextStyle defaultTextStyle;

  GlobalKey<FormState>? previousKey;

  @override
  void dispose() {

     widget._cInputController.dispose();
     super.dispose();
  }

  @override
  void initState() {

    defaultTextStyle = TextStyle(color: Colors.grey[600], fontSize: widget.fontSize);


    previousKey = widget.mKey;
    widget._cInputController.shouldNotUpdateText = widget.shouldNotUpdateText;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    if(widget.mKey != null && widget.mKey != previousKey){
      widget._cInputController.reset();
      previousKey = widget.mKey;
    }

    widget._cInputController.doNotValidate = widget.doNotValidate;

    return Form(
      key: widget._cInputController.formKey,
      child: TextFormField(



        // inputDecorationTheme: InputDecorationTheme(
        //     isDense: true,// this will remove the default content padding
        //     // now you can customize it here or add padding widget
        //     contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        //     ...
        // ),

        enableSuggestions: true,
        style: widget.textStyle ?? defaultTextStyle,
        showCursor: widget.showCursor,
        focusNode: widget._cInputController.focusNode,
        maxLength: widget.maxLength,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        keyboardType: widget.digitsOnly == false ? null : TextInputType.number,
        inputFormatters: widget.digitsOnly == false ? null : <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        obscureText: widget.isPassword,
        controller: widget._cInputController.textController,
        maxLines: widget.minLines,
        onChanged:(dynamic s){

              widget._cInputController.setSelectedValue(s, setTextControllerValue: false);
              widget._cInputController.onChange(s);
        },
        validator: (s){
          return widget._cInputController.inputValidation?.call(s) ??
              (widget.isEmail == true ? _emailValidation(s) : null);
        },


        decoration:
        widget.inputDecoration ??
        InputDecoration(

         contentPadding: widget.contentPadding,
         // EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          
          isDense: true,

            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,

            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? defaultBorderColor, width: widget.borderWidth ?? defaultBorderWidth),
              borderRadius: BorderRadius.circular(widget.radius ?? defaultRadius),
            ),
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? defaultBorderColor, width: widget.borderWidth ?? defaultBorderWidth),
              borderRadius: BorderRadius.circular(widget.radius ??defaultRadius),
            ),
            errorBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: widget.borderWidth ?? defaultBorderWidth),
              borderRadius: BorderRadius.circular(widget.radius ??defaultRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: widget.borderWidth ?? defaultBorderWidth),
              borderRadius: BorderRadius.circular(widget.radius ??defaultRadius),
            ),


            focusColor: Colors.grey,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: widget.hintColor ?? defaultHintColor),
        ),
      ),
    );
  }
}





import 'package:c_input/c_input.dart';
import 'package:c_ui/c_ui.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';

class SharedUi{

  static Color getColor(ColorType type){
    switch(type){
      case ColorType.dark:
        return Colors.grey.shade900;
      case ColorType.dark2:
        return Colors.grey.shade400;
      case ColorType.error:
        return Colors.red.shade300;
      case ColorType.danger:
        return Colors.red.shade800;
      case ColorType.faint:
        return Colors.blue.shade50;
      case ColorType.success:
        return Colors.green.shade700;
      case ColorType.successLight:
        return Colors.green.shade200;
      case ColorType.outlier:
        return Colors.purple.shade900;
      case ColorType.light:
        return Colors.grey.shade50;
      case ColorType.light2:
        return Colors.grey.shade100;
      case ColorType.info:
        return Colors.blue.shade500;
      case ColorType.infoLight:
        return Colors.blue.shade100;
      case ColorType.warning:
        return Colors.orange.shade300;
      case ColorType.secondary:
        return Colors.grey.shade700;
      case ColorType.secondary2:
        return Colors.blueGrey;
      case ColorType.divergent:
        return Colors.yellow.shade200;
      case ColorType.divergentLight:
        return Colors.yellow.shade100;
      default:
        return Colors.red.shade300;
    }
  }

  
  //texts
  static Widget largeText(String text, {bool bold : false, TextAlign? alignment, double? size, ColorType colorType: ColorType.dark, int maxLine:1, double? letterSpacing, double? wordSpacing, double? height}){
    return CText(text, size: size ?? 45, fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      letterSpacing: letterSpacing, wordSpacing: wordSpacing, height: height, alignment: alignment,
      color: getColor(colorType), maxLine: maxLine, overflow: TextOverflow.ellipsis,
    );
  }



  static Widget normalText(String text, {bool bold : false, TextAlign? alignment, double? size, ColorType colorType: ColorType.dark, int maxLine: 1, double? letterSpacing, double? wordSpacing, double? height}){
    return CText(text, size: size ?? 25, fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      letterSpacing: letterSpacing, wordSpacing: wordSpacing, height: height, alignment: alignment,
      color: getColor(colorType), maxLine: maxLine, overflow: TextOverflow.ellipsis,
    );
  }

  static Widget mediumText(String text, {bool bold : false, TextAlign? alignment, double? size, ColorType colorType: ColorType.dark, int maxLine:1, double? letterSpacing, double? wordSpacing, double? height}){
    return CText(text, size: size ?? 19, fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      letterSpacing: letterSpacing, wordSpacing: wordSpacing, height: height, alignment: alignment,
      color: getColor(colorType), maxLine: maxLine, overflow: TextOverflow.ellipsis,
    );
  }

  static Widget smallText(String text, {bool bold : false, TextAlign? alignment, double? size, ColorType colorType: ColorType.dark, int maxLine:100000, double? letterSpacing, double? wordSpacing, double? height}){
    return CText(text, size: size ?? 15, fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      letterSpacing: letterSpacing, wordSpacing: wordSpacing, height: height, alignment: alignment,
      color: getColor(colorType), maxLine: maxLine, overflow: TextOverflow.ellipsis,
    );
  }





  static Widget vMediumSpace() {
    return SizedBox(
      height: 100,
    );
  }

  static Widget vSmallSpace() {
    return SizedBox(
      height: 30,
    );
  }

  static Widget vTinySpace() {
    return SizedBox(
      height: 10,
    );
  }

  static Widget vFooterSpace() {
    return SizedBox(
      height: 120,
    );
  }

  static Widget vHeaderSpace() {
    return SizedBox(
      height: 50,
    );
  }




  // input fields
  static Widget mTextField(CInputController cInputController, String label, String hint, {bool? isDigit, bool? isEmail, bool? isPassword, GlobalKey<FormState>? mKey, bool doNotValidate:false, bool isEditable:true, int minLine: 1, bool isRequired:true}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        SharedUi.mediumText(label, colorType: ColorType.secondary),

        SizedBox(height: 10,),

        CTextField(cInputController,  doNotValidate: doNotValidate, mKey:mKey, hintText: hint,
          readOnly: !isEditable, minLines: minLine,
          isEmail: isEmail ?? false, isPassword: isPassword ?? false, digitsOnly: isDigit ?? false,),
        SizedBox(height:20),
      ],
    );
  }


  static Widget mDropDown({required List dropDownList,
    required CInputController inputController,
    required String label, required String hint,
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        mediumText(label, colorType: ColorType.secondary),
        SizedBox(height: 10,),
        CDropDown(dropDownList,  inputController,
          hintText: hint, ),
        SizedBox(height:20),

      ],
    );
  }


  static Widget mDateOfBirth({required CInputController dateOfBirthController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        mediumText("Date of birth", colorType: ColorType.secondary),
        SizedBox(height: 10,),
        CDatePicker(cInputController: dateOfBirthController, yearPlus: 18,),
        SizedBox(height:20),
      ],
    );
  }


  static Widget mSwitch({String? label, required bool switchValue, void onSwitchChange(bool? val)?, }){
    return Row(
      children: [

        Switch(
            value: switchValue,
            onChanged: onSwitchChange
        ),

        Flexible(child: CText(label ?? "", size: 15,)),

      ],
    );
  }




  //buttons
  static Widget mButton({Widget? append, Widget? prepend, String? label,ColorType? buttonColorType, ColorType? textColorType, void Function()? onTap,
    double? height, double? edgePads, double factor: 10, double? fontSize}){

    Widget child;

    if(append != null || prepend != null){
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(append != null) append,
          if(!((append!=null || prepend!=null) && label == null))
          CText(label ?? "      ", size: fontSize ?? 15, color: getColor(textColorType ?? ColorType.light),),
          if(prepend != null) prepend,
        ],
      );
    }else
      child = CText(label ?? "      ", size: fontSize ?? 15, color: getColor(textColorType ?? ColorType.light));



    return ButtonAnimator2(
      onTap2: onTap,

      child: Container(
        alignment: Alignment.center,
        height: height != null ? height * factor : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: getColor(buttonColorType ?? ColorType.success),
        ),
        padding: EdgeInsets.symmetric(horizontal: edgePads ?? 9,),
        child: child,
      ),
    );

  }

  // static Widget successButton({Widget? append, Widget? prepend, String? label,
  //   Function()? onTap, double? edgePads, double? fontSize}){
  //
  //   return _button(append: append, prepend: prepend, label: label, buttonColorType: ColorType.success,
  //     textColorType: ColorType.light, fonsize: fontSize,
  //     onTap: onTap, height: 3, edgePads: edgePads ?? 20,);
  //
  // }
  //
  // static Widget cancelButton({Widget? append, Widget? prepend, String? label,
  //   Function()? onTap, double? edgePads, double? fontSize}){
  //
  //   return _button(append: append, prepend: prepend, label: label, buttonColorType: ColorType.danger,
  //     textColorType: ColorType.light,
  //     onTap: onTap, height: 3, edgePads: edgePads ?? 20, fontSize: fontSize);
  //
  // }



  //button
  // static Widget mButton(String label, {required Function() onTap,
  //   ColorType buttonColorType: ColorType.info,
  //   ColorType textColorType : ColorType.light,
  //   ColorType borderColorType : ColorType.divergent,
  //   Icon? leadingIcon,
  //
  // }){
  //   return  ButtonAnimator2(
  //     onTap: onTap,
  //     child: AnimatedContainer(
  //       duration: Duration(milliseconds: 300),
  //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  //       decoration: BoxDecoration(
  //           color: SharedUi.getColor(buttonColorType),
  //           border: Border.all(color: SharedUi.getColor(ColorType.divergent)),
  //           borderRadius: BorderRadius.circular(20)
  //       ),
  //
  //       child: Row(
  //
  //           children: [
  //             if(leadingIcon != null) leadingIcon,
  //             SharedUi.smallText(label, colorType: textColorType),
  //
  //           ]
  //       ),
  //     ),
  //   );
  // }



  //images

  static Widget logo1() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Image(image: AssetImage("assets/images/hms_logo.png"),),
    );
  }



  static Widget femaleAvatar(){
    return ClipOval(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/images/female_avatar.png"),
      ),
    );
  }

  static slimButton() {}

  // get femaleAvatar => null;

}
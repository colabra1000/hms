import 'package:c_input/c_input.dart';
import 'package:c_ui/c_ui.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';

class SharedUi{

  static Color getColor(ColorType type){
    switch(type){
      case ColorType.dark:
        return Colors.grey.shade900;
      case ColorType.danger:
        return Colors.red.shade300;
      case ColorType.faint:
        return Colors.blue.shade50;
      case ColorType.success:
        return Colors.green.shade400;
      case ColorType.outlier:
        return Colors.purple.shade900;
      case ColorType.light:
        return Colors.grey.shade50;
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
      default:
        return Colors.red.shade300;
    }
  }
  
  //texts


  static Widget largeText(String text, {bool bold : false, double? size, ColorType colorType: ColorType.dark, int maxLine:1}){
    return CText(text, size: size ?? 45, fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      color: getColor(colorType), maxLine: maxLine, overflow: TextOverflow.ellipsis,
    );
  }



  static Widget normalText(String text, {bool bold : false, double? size, ColorType colorType: ColorType.dark, int maxLine: 1}){
    return CText(text, size: size ?? 25, fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      color: getColor(colorType), maxLine: maxLine, overflow: TextOverflow.ellipsis,
    );
  }

  static Widget mediumText(String text, {bool bold : false, double? size, ColorType colorType: ColorType.dark, int minLine:1}){
    return CText(text, size: size ?? 19, fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      color: getColor(colorType), maxLine: minLine, overflow: TextOverflow.ellipsis,
    );
  }

  static Widget smallText(String text, {bool bold : false, double? size, ColorType colorType: ColorType.dark, int maxLine:1}){
    return CText(text, size: size ?? 15, fontWeight: bold ? FontWeight.bold : FontWeight.w500,
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
  static Widget _button(List<dynamic> head, Color color, {
    EdgeInsets? padding,
    void Function()? onTap,}){


    List<Widget> headWidgets = head.map((e) {
      assert(e != null);
      if(e is String){
        return CText(e, size: 15, color: Colors.grey.shade50,);
      }else{
        return e as Widget;
      }

    }).toList();

    return CButton(
      onTapHandler: onTap,
      elevation: 2,
      borderRadius: 19,
      color: color,
      padding: EdgeInsets.all(9),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,

        child: Row(
          children: [...headWidgets],
        ),
      ),
    );

  }

  static Widget successButton(List<dynamic> head,  {void Function()? onTap, EdgeInsets? padding,}){

    return _button(head, Colors.green ,onTap: onTap, padding: padding);

  }

  static Widget cancelButton(List<dynamic> head,  {void Function()? onTap, EdgeInsets? padding,}){

    return _button(head, Colors.red ,onTap: onTap);

  }



  //images

  static Widget logo1() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Image(image: AssetImage("assets/images/hms_logo.png"),),
    );
  }

  static Widget logo2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image(image: AssetImage("assets/images/cac-Logo.png"),),
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

  // get femaleAvatar => null;

}
import 'package:c_input/src/CInputController.dart';
import 'package:c_ui/c_ui.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/variables/GlobalData.dart';
import 'package:provider/provider.dart';


class SharedWidgets{

  static Widget headerText(String text, {bold:true}){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 30),
        CText(text, alignment: TextAlign.start,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
        Divider(),
        SizedBox(height: 5),
      ],
    );
  }

  static Widget titleValueText(String title, String value){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 5),
        CText(title, alignment: TextAlign.start,size: 18, ),
        CText(value, alignment: TextAlign.start,size: 15, color: Colors.green.shade700,),
        Divider(),
        SizedBox(height: 5),
      ],
    );
  }





  static Widget continueButtonWarningBlock<T>({required bool Function(T) listenTo, }){

    return  Selector(

      selector: (_, T model) => listenTo(model),

      builder:(_, bool value, __) =>

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 500),
              firstChild:  Container(),

              secondChild: Container(

                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade50
                  ),

                  child: CText("please fill required fields before proceeding", color: Colors.red, size: 14,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  )),
              crossFadeState: value ? CrossFadeState.showFirst : CrossFadeState.showSecond,

            ),
          ),
    );
  }

  static Widget mSelectGender({required CInputController genderInputController, String label: "Gender", String hint: "Select Gender"}) {
    return SharedUi.mDropDown(dropDownList: GlobalData.gender,
        inputController: genderInputController, label: label, hint: hint,);

  }

  static Widget profileBox() {
    return   Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: AspectRatio(
        aspectRatio: 1,
      ),
    );
  }


  static Widget readStatus(String readStatus){
    return  Container(
      height: 10,
      decoration: BoxDecoration(
          color: readStatus == "UNSEEN" ? SharedUi.getColor(ColorType.danger) :
          readStatus == "UNREAD" ? SharedUi.getColor(ColorType.success) :
          null,

          borderRadius: BorderRadius.circular(5)
      ),
      child: AspectRatio(
        aspectRatio: 1,
      ),
    );
  }



  static Widget badge(String quantity, ColorType colorType){

    return SizedBox(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: SharedUi.getColor(colorType))
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SharedUi.smallText(quantity, colorType: ColorType.outlier, maxLine: 1, bold: true),
          )
        ],
      ),
    );
  }







}
import 'package:c_input/src/CInputController.dart';
import 'package:c_ui/c_ui.dart';
import 'package:flutter/material.dart';
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






}
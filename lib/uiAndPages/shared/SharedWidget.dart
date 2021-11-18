import 'package:c_input/src/CInputController.dart';
import 'package:c_ui/c_ui.dart';
import 'package:flutter/material.dart';
import 'package:hms/data/GlobalData.dart';
import 'package:hms/enums.dart';
import 'package:hms/services/MessageService.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
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
    return SharedUi.mDropDown(dropDownList: GlobalData.genders,
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


  static Widget indicateItemState(BuildContext context, int? readStatus){
    return  Container(
      height: MediaQuery.of(context).size.height * .015,
      decoration: BoxDecoration(
          color: readStatus == MessageService.NEW ? SharedUi.getColor(ColorType.danger) :
          readStatus == MessageService.UNREAD ? SharedUi.getColor(ColorType.success) :
          null,

          shape: BoxShape.circle,
      ),
      child: AspectRatio(
        aspectRatio: 1,
      ),
    );
  }


  static Widget badge(BuildContext context, int? quantity, ColorType colorType){

    String qty = "${(quantity?.toString().length ?? 0) > 3 ? "∞" : quantity ?? "..."}";
    return SizedBox(
      width: MediaQuery.of(context).size.width * .2,
      // height: 30,
      child: AspectRatio(
        aspectRatio: 1,
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
              child: SharedUi.smallText(qty, colorType: ColorType.outlier, maxLine: 1, bold: true, size: MediaQuery.of(context).size.width * .15),
            )
          ],
        ),
      ),
    );
  }


  static Widget modalScaffold(context, {required Widget child}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(

          margin: EdgeInsets.symmetric(horizontal: 10),

          decoration: BoxDecoration(
            color: SharedUi.getColor(ColorType.light2),
            borderRadius: BorderRadius.circular(20),
          ),

          height: MediaQuery.of(context).size.height * .5,

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          ),
        ),
      ],
    );
  }






}
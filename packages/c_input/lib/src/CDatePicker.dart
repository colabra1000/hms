 import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'CInputController.dart';
import 'CTextField.dart';


class CDatePicker extends StatefulWidget {

  final CInputController cInputController;
  final int? yearPlus;

  const CDatePicker({Key? key, required this.cInputController, this.yearPlus}) : super(key: key);

  @override
  _CDatePickerState createState() => _CDatePickerState();
}

class _CDatePickerState extends State<CDatePicker> {
  DateTime? currentlySelected;

  ValueNotifier dateListener = ValueNotifier<String>("");

  // final DateTime? picked;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      helpText: "Select date of birth",
      fieldHintText: "month/day/year",
      context: context,
      initialDate: currentlySelected ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),

      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child!,
        );
      },
    );



    if (picked != null && picked != currentlySelected){

      currentlySelected = picked;

      widget.cInputController.setSelectedValue("${picked.toIso8601String()}Z");
      dateListener.value = "${picked.toIso8601String()}Z";

      String formattedDate = formatDate(currentlySelected!, [yyyy, '-', mm, '-', dd]);

      widget.cInputController.setTextField(formattedDate);
      //this is needed here
      widget.cInputController.validate();


    }

  }


  validateAge(dynamic input){

    assert(widget.yearPlus != null);

      int yearPlus = widget.yearPlus!;

      DateTime? selectedDate = DateTime.tryParse(input);

      if(selectedDate != null && selectedDate.isAfter(
          DateTime.now().subtract(Duration(days: ((355 * yearPlus) + (yearPlus * .25).floor())))
      )){
        return "You must be 18 years and older";
      }


      if(selectedDate == null){
        return "you must select date of birth";
      }
      return null;
  }


  @override
  void initState() {

     widget.cInputController.inputValidation = (dynamic input){

       var ageValidation = widget.yearPlus != null ? validateAge(input) : null;

       if(ageValidation != null){
         return ageValidation;
       }

       return widget.cInputController.validationRule!(input);

     };

     super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        FocusScope.of(context).unfocus();
        _selectDate(context);
      },
      child: IgnorePointer(

        child: ValueListenableBuilder(
          valueListenable: dateListener,
          builder: (context, value, _) {
            return CTextField(widget.cInputController, showCursor: true, readOnly:true, hintText: "YYYY-MM-DD",);
          }
        ),

      ),
    );
  }
}

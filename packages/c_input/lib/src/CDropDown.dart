 import 'package:c_input/src/CInputController.dart';
import 'package:flutter/material.dart';

class CDropDown extends StatefulWidget {

    final List items;
    final CInputController cInputController;
    final double? radius;
    final String? hintText;
    final double? borderWidth;
    final Color? borderColor;
    final Color? hintColor;
    final TextStyle? selectedItemTextStyle;
    final bool? readOnly;
    final bool doNotValidate;
    final bool showLoading;

    CDropDown(this.items, this.cInputController, {this.showLoading:false, this.selectedItemTextStyle, this.hintColor, this.hintText, this.borderColor, this.borderWidth, this.radius, this.readOnly, this.doNotValidate:false,});


  @override
  _CDropDownState createState() => _CDropDownState();
}

class _CDropDownState extends State<CDropDown> {

    final defaultBorderColor = Colors.green.shade500;
    final double defaultRadius = 5;
    final double defaultBorderWidth = 1;
    final Color defaultHintColor = Colors.grey.shade400;
    List items = [];

    @override
    void didUpdateWidget(CDropDown oldWidget) {
        widget.readOnly == true ?
        items = [widget.cInputController.selectedValue ?? ""]
            :
        items = widget.items;

    super.didUpdateWidget(oldWidget);
  }


    @override
    void initState() {


      widget.readOnly == true ?
      items = [widget.cInputController.selectedValue ?? ""]
          :
      items = widget.items;

    super.initState();
  }


  bool valueIsUnChanged = true;





  @override
  void dispose() {
      widget.cInputController.dispose();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    widget.cInputController.doNotValidate = widget.doNotValidate;

    return

    Form(

        key: widget.cInputController.formKey,
        child: FormField<dynamic>(

          builder: (FormFieldState<dynamic> state) {
              return DropdownButtonFormField<dynamic>(

                    decoration: InputDecoration(
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

                  icon: widget.showLoading ?
                  AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.grey,
                    ),
                  ) : Icon(Icons.arrow_drop_down,),



                  validator: widget.cInputController.inputValidation ,
                    isExpanded: true,
                  dropdownColor: Colors.grey[100],

                value: _getSelectedValue(),
                isDense: true,
                  // itemHeight: 50,

                  onChanged: (dynamic newValue) {
                      setState(() {

                        widget.cInputController.onChange(newValue);
                        widget.cInputController.setSelectedValue(newValue);
                        //this is necessary!
                        widget.cInputController.formKey.currentState?.validate();

                      });
                  },

                  selectedItemBuilder: (BuildContext context) {
                    return items.map<Widget>((dynamic item) {

                        return Container(
                            alignment: Alignment.centerLeft,
                            child: Text(item is String ? item :  item.label,
                                style: widget.selectedItemTextStyle ?? TextStyle(fontSize: 12,))
                        );
                    }).toList();
                  },

                  items:items.map<DropdownMenuItem<dynamic>>((dynamic item) {

                      return DropdownMenuItem<dynamic>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(item is String ? item : item.label),
                          ),
                      );
                  }).toList(),
              );
          },
      ),
    );
  }

    dynamic _getSelectedValue(){
      //only returns for the first instance
      if(valueIsUnChanged){

        valueIsUnChanged = false;

        try{
          int initialValue = widget.cInputController.initialValue;

          dynamic value = items[initialValue];

          widget.cInputController.setSelectedValue(value);
          return  value;

        }catch(e){


          // selectedvalue is automatically set in the
          // cInputController's constructor, since it is
          // an illegal value, it needs to be reset here!
          // before it is returned.
          widget.cInputController.reset();
          return widget.cInputController.selectedValue;
        }
      }

      return widget.cInputController.selectedValue;
    }
}



























//class _CDropDownState extends State<CDropDown> {
//    String dropdownValue;
//
//    final defaultBorderColor = Colors.grey[700];
//    final double defaultRadius = 25.7;
//    final double defaultBorderWidth = 3;
//    final Color defaultHintColor = Colors.grey[400];
//
//    @override
//    Widget build(BuildContext context) {
//        return
//
//            Form(
////        autovalidate: true,
//                key: widget.fieldAndLabelPassers.formKey,
//                child: FormField<String>(
//                    validator: widget.fieldAndLabelPassers.validation,
//                    builder: (FormFieldState<String> state) {
//                        return InputDecorator(
//                            decoration: InputDecoration(
//                                filled: true,
//                                fillColor: Colors.white,
//                                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
//
//                                enabledBorder: OutlineInputBorder(
//                                    borderSide: BorderSide(color: widget.borderColor ?? defaultBorderColor, width: widget.widget.borderWidth ?? defaultBorderWidth),
//                                    borderRadius: BorderRadius.circular(widget.widget.radius ?? defaultRadius),
//                                ),
//                            ),
//                            child: DropdownButtonHideUnderline(
//
//                                child: DropdownButton<String>(
////                        iconSize: 30,
////                    itemHeight: 100,
//                                    dropdownColor: Colors.grey[100],
//                                    hint: CText(widget.hintText ?? "", color: defaultHintColor, size: 17,padding: EdgeInsets.zero),
//                                    value: dropdownValue,
//                                    isDense: true,
//                                    onChanged: (String newValue) {
//                                        setState(() {
//                                            dropdownValue = newValue;
//                                            widget.fieldAndLabelPassers.controller.text = newValue;
//                                            widget.onChange(newValue);
//                                        });
//                                    },
//
//                                    items:widget.items.map<DropdownMenuItem<String>>((String value) {
//                                        return DropdownMenuItem<String>(
//                                            value: value,
//                                            child: Text(value),
//                                        );
//                                    }).toList(),
//                                ),
//                            ),
//                        );
//                    },
//                ),
//            );
//    }
//}
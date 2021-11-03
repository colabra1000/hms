import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'CData.dart';
import 'CInputController.dart';

class CDropDownSearch extends StatefulWidget {

    final Color? borderColor;
    final double? borderWidth;
    final double? radius;
    final List? items;
    final String? hintText;
    final String? popUpTitle;
    final CInputController fieldAndLabelPassers;
    final Color? hintColor;
    final Future<List<dynamic>> Function(String)? onLoad;



    CDropDownSearch(this.fieldAndLabelPassers, {this.hintColor, this.hintText, this.popUpTitle, this.borderColor, this.borderWidth, this.radius, this.items, this.onLoad,});

  @override
  _CDropDownSearchState createState() => _CDropDownSearchState();
}

class _CDropDownSearchState extends State<CDropDownSearch> {
    final Color defaultBorderColor = Colors.green[600]!;

    final double defaultRadius = 5;

    final double defaultBorderWidth = 1;

    final Color defaultHintColor = Colors.grey[400]!;

    @override
  void initState() {

     super.initState();
  }

  @override
  void dispose() {
    widget.fieldAndLabelPassers.dispose();
     super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  Form(
        key: widget.fieldAndLabelPassers.formKey,
      child: DropdownSearch<dynamic>(

          searchBoxController: widget.fieldAndLabelPassers.textController,

          popupTitle: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(widget.popUpTitle ?? "", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),

          validator: widget.fieldAndLabelPassers.inputValidation,

          isFilteredOnline: true,

          searchDelay: Duration(seconds: 1),

          

          // dropdownSearchDecoration: InputDecoration(
          //     contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
          //     border: OutlineInputBorder()),








          // dropdownSearchBaseStyle: ,

          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
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
//              labelText: hintText,
              hintStyle: TextStyle(color: widget.hintColor ?? defaultHintColor),
          ),
          popupItemBuilder: _customPopupItemBuilder,
          dropdownBuilder: _customDropDown,
          mode:Mode.DIALOG,
          selectedItem: widget.fieldAndLabelPassers.selectedValue,
          items: widget.items,
          onFind: widget.onLoad,
          maxHeight: MediaQuery.of(context).size.height/1.5,

          itemAsString: (dynamic u){
              if(u is String) return u;
              if(u is CData) return u.label;
              return u.toString();
          },
          onChanged: (dynamic s){
              Future.delayed(Duration(milliseconds: 500), (){
                  widget.fieldAndLabelPassers.onChange(s);
                  widget.fieldAndLabelPassers.setSelectedValue(s);
                  // print(fieldAndLabelPassers.selectedValue);
                  // fieldAndLabelPassers.formKey.currentState.validate();

              });
          },
          showSearchBox: true,
      ),
    );
  }

    Widget _customDropDown(
        BuildContext context, dynamic item, String itemDesignation) {
        return Container(
            // height: 5,
            child: item == null ? Text(widget.hintText ?? "", style: TextStyle(color: widget.hintColor ?? defaultHintColor), textAlign : TextAlign.left) :
                    Text(item is CData ? item.label : item.toString()),

        );
    }

    Widget _customPopupItemBuilder(
        BuildContext context, dynamic item, bool isSelected) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: !isSelected
                ? null
                : BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: item is CData ? ListTile(
                  selected: isSelected,
                  title: Text(item.label),
              ) : item is String ? ListTile(
              selected: isSelected,
              title: Text(item),):
                  null,
            )
        );
    }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:provider/provider.dart';


class PageLayout{


  static Widget layout<T>({String? title, Widget? titleIcon, Widget? body,
    void Function()? onBackPressed, bool Function(T)? isLoading, Widget? loadingIndicator,
    ColorType? backgroundColorType}){
    return Builder(
      builder: (context) {
        return WillPopScope(

          onWillPop: ()async{
            onBackPressed?.call();
            return true;
          },

          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor:
              SharedUi.getColor(backgroundColorType ?? ColorType.light2),

              body: SafeArea(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Expanded(child: Row(
                                  children: [
                                    title == null ? Container() :
                                    Flexible(child: SharedUi.mediumText(title)),

                                    SizedBox(width: 10,),
                                    titleIcon == null ? Container() :
                                    titleIcon,

                                  ],
                                )),


                                // Spacer(),

                                SizedBox(width: 10,),

                                onBackPressed == null ?
                                Container() :
                                SharedUi.mButton(
                                    height: 3,
                                    prepend: Icon(CupertinoIcons.back, size: 15,),
                                    edgePads: 20,
                                    buttonColorType: ColorType.infoLight,
                                    textColorType: ColorType.dark,
                                    label: "back",
                                    onTap: onBackPressed
                                ),
                              ],
                            ),
                          ),
                        ),

                        Selector(


                            selector: (_, T model)=>isLoading?.call(model),

                            builder: (_, bool? value, __) {

                              return Expanded(
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 500),
                                  child: value == true ? loadingIndicator ??
                                  _loadingIndicator():
                                  body ?? Container(),
                                ),
                              );


                            }
                        ),

                      ],
                    ),
                  )
              ),
            ),
          ),
        );
      }
    );
  }




  //todo replace this with cmodal.
  static Widget _loadingIndicator(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}

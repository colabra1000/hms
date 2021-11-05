library cmodal;

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'CModalController.dart';
part 'CModalStateChanger.dart';
part 'Enums.dart';




class CModal extends StatefulWidget {


  final Widget child;
  final CModalController controller;
  final Widget? Function (BuildContext, CModalState)? builder;


  CModal({required this.child, required this.controller, this.builder});

  @override
  State<CModal> createState() => _CModalState();
}

class _CModalState extends State<CModal> {
  final List<Widget> widgetChildren = [];

  final ValueNotifier<double> opacityValue = ValueNotifier(0);


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(

    onWillPop:  () async {

      // if modal is not display, then can pop freely.
      if(widget.controller._state == CModalState.none){
        return true;
      }

      // calls user defined on back press function.
      widget.controller.onBackPress?.call();

      //handle to dismiss when back is pressed.
      if(widget.controller.dismissOnBackPress == true){
        widget.controller.changeModalState = CModalStateChanger(state: CModalState.none);
        return false;
      }

      //handle to pop when back is pressed.
      if(widget.controller.popOnBackPress == true){
        return true;
      }

      return false;

    },

      child: ValueListenableBuilder(

      valueListenable: widget.controller._notify,

      builder: (BuildContext context, CModalState cState, _){


        widgetChildren.clear();

        final modalBackGround = _getModalBackGround();

        //expose the context through the controller
        widget.controller.context = context;

        //first add the parent display
        //meant to always stay behind modal and modal background
        widgetChildren.add(widget.child);

        //sets the modal display
        Widget? modalDisplay = _getModalDisplay(cState);


        //if to display modalDisplay
        if(cState != CModalState.none){

          _addModalBackGroundWidget(modalBackGround);

          //shouldn't even be null
          if(modalDisplay != null) {

            widgetChildren.add(modalDisplay);
          }

          FocusScope.of(context).unfocus();

        }
        else{
          _resetControllerState();
        }

        return Scaffold(
          body: Stack(
            children: widgetChildren,
          ),
        );
      },
    ),
    );
  }

  //resets states for this current state
  //so that changes do not persist for the next call.
  //not needed for now
  _resetControllerState(){
    // widget.controller.displayMessage = null;
    // widget.controller.dismissOnOutsideClick = false;
    // widget.controller.modalDisplay = null;

  }

  //determines the modal display based on modal state
  _getModalDisplay(CModalState cState){
    return widget.controller.modalDisplay ??
        widget.builder?.call(context, cState) ?? _defaultBuilder(context, cState);
  }


  //constructs the modal display
  //used to construct modal displays in default builder
  Widget _constructModalDisplayDefaults(CModalState modalState){

    String text = modalState == CModalState.error ? widget.controller.displayMessage ?? "error!!" :
        modalState == CModalState.success ? widget.controller.displayMessage ?? "successful" :
            widget.controller.displayMessage ?? "Hey!";

    Color color = modalState == CModalState.error ? Colors.red :
    modalState == CModalState.success ? Colors.green :
        Colors.blue;


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [


        Container(

          margin: EdgeInsets.all(20),

          alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20)
            ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                text, style: TextStyle(fontSize: 15, color: Colors.white),
              ),
          ),
        ),



        ElevatedButton(
            onPressed: (){
          widget.controller._state = CModalState.none;
        },
            child: Text("OK", style: TextStyle(fontSize: 19),)),
      ],
    );
  }

  //in use when user does not provide a builder
  Widget? _defaultBuilder(BuildContext context, CModalState cState) {

    if(cState == CModalState.loading){

      return Center(child :CircularProgressIndicator());

    }else if (cState == CModalState.error){

      return _constructModalDisplayDefaults(CModalState.error);

    }else if (cState == CModalState.success){

       return _constructModalDisplayDefaults(CModalState.success);

    }

    return _constructModalDisplayDefaults(CModalState.custom1);

  }

  //wrap modal background in do opacity effect and add to widgetChildren
  void _addModalBackGroundWidget(Widget modalBackground) {
    widgetChildren.add(DoOpacity(
      fadeDuration: widget.controller.fadeDuration,
      child: modalBackground
    ));



  }

  //constructs the modal background with gesture detector and backdrop filter
  Widget _getModalBackGround(){
    return GestureDetector(

      onTap: (){
        //dismiss when user clicks outside the display modal.
        if(widget.controller.dismissOnOutsideClick == true){
          widget.controller._state = CModalState.none;
        }

        //calls user defined function.
        widget.controller.onOutsideClick?.call();

      },

      //blurs the background
      child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              color: Colors.black.withOpacity(.7),
            ),
          )
      ),


    );
  }



}



class DoOpacity extends StatefulWidget {

  final Widget child;
  final Duration? fadeDuration;
  DoOpacity({Key? key, required this.child, this.fadeDuration}) : super(key: key);

  @override
  _DoOpacityState createState() => _DoOpacityState();
}

class _DoOpacityState extends State<DoOpacity> {

  late ValueNotifier<double> opacityValue;

  @override
  void initState() {

    opacityValue = ValueNotifier(0);

    Future.delayed(Duration.zero, (){
      opacityValue.value = 1;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return


      ValueListenableBuilder(
        valueListenable: opacityValue,
        builder:(_, value, __){

          return AnimatedOpacity(
              duration: widget.fadeDuration ?? Duration(milliseconds: 600),
              opacity: opacityValue.value,
              child: widget.child);
        },
      );

  }
}










import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PopperPanel extends StatefulWidget {

  final Widget child;
  final ValueNotifier<bool> popperOpened;
  final Function onOpen;
  final Function onClose;

  // final Completer? onDismissCompleter;

  PopperPanel({Key? key, required this.child, required this.popperOpened, required this.onOpen, required this.onClose}):super(key: key);


  @override
  _PopperPanelState createState() => _PopperPanelState();
}

class _PopperPanelState extends State<PopperPanel> {


  late ValueNotifier<bool> _displayAdderPanel;

  @override
  void initState() {



    _displayAdderPanel = widget.popperOpened;
    _displayAdderPanel.value = false;

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp){
      _displayAdderPanel.value = true;
    });


    super.initState();

  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(

      onTap: (){
        FocusScope.of(context).unfocus();

      },

      child: Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ValueListenableBuilder(

            valueListenable: _displayAdderPanel,

            builder:(_, bool value, child){

              return AnimatedContainer(
                curve: value == true ? Curves.easeOutCubic :
                Curves.easeIn,
                duration: Duration(
                  milliseconds: value == true ?  800 : 400,),
                onEnd: (){
                  if(value == false){
                    widget.onClose();
                  }

                  if(value == true){
                    widget.onOpen();
                  }

                  // if(value == true){
                  //   widget.onDismissCompleter
                  // }
                },
                decoration: BoxDecoration(

                    gradient : LinearGradient(
                        colors: [
                          Colors.grey.shade100,
                          Colors.grey.shade50,
                        ]

                    ),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40))
                ),

                height: value ? MediaQuery.of(context).size.height * .82 : 0,
                width: double.infinity,


                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Column(
                    children: [
                      Flexible(child: Divider(color: Colors.lightGreen.shade900, thickness: 1,)),

                      Expanded(
                        flex: 500,
                        child: child!,
                      ),
                    ],
                  ),
                ),
              );
            },

            child: widget.child,
          ),
        ),
      ),
    );
  }
}

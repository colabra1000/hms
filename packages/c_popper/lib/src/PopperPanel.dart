import 'package:flutter/cupertino.dart';
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




    return SafeArea(
      child: GestureDetector(

        onTap: (){
          FocusScope.of(context).unfocus();

        },

        child: Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder(

              valueListenable: _displayAdderPanel,

              builder:(_, bool value, child){




                return Stack(
                  children: [

                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .18 -  MediaQuery.of(context).padding.top,

                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: ()=>widget.popperOpened.value = false,
                          child: AnimatedContainer(
                            duration: Duration(
                              milliseconds: value == true ?  800 : 400,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),


                            decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(20)
                            ),

                            constraints: BoxConstraints(
                              maxWidth: 150,
                              minWidth: value ? 100 : 0
                            ),

                            width: !value ? 0 : MediaQuery.of(context).size.width * .3,

                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ClipRect(child: Icon(CupertinoIcons.back)),
                                  Text("back", style: TextStyle(color: Colors.grey.shade900), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    AnimatedPositioned(

                        onEnd: (){
                          if(value == false){
                            widget.onClose();
                          }

                          if(value == true){
                            widget.onOpen();
                          }


                        },


                        bottom: !value ? -MediaQuery.of(context).size.height * .82 : 0,
                        curve: value == true ? Curves.easeOutCubic :
                        Curves.easeIn,
                        height: MediaQuery.of(context).size.height * .82,
                        width: MediaQuery.of(context).size.width,
                        duration: Duration(
                              milliseconds: value == true ?  800 : 400,
                        ),

                        child: Container(
                          decoration: BoxDecoration(
                            gradient : LinearGradient(
                                colors: [
                                  Colors.grey.shade100,
                                  Colors.grey.shade50,
                                ]

                            ),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(40))
                          ),

                          // width: double.infinity,

                          child: Column(
                            children: [

                              SizedBox(height: 30),

                              Divider(color: Colors.lightGreen.shade900, thickness: 1,),

                              Expanded(
                                flex: 500,
                                child: child!,
                              ),
                            ],
                          ),




                        ),
                    )

                  ],
                );


                // AnimatedContainer(
                //   curve: value == true ? Curves.easeOutCubic :
                //   Curves.easeIn,
                //   duration: Duration(
                //     milliseconds: value == true ?  800 : 400,),
                //   onEnd: (){
                //     if(value == false){
                //       widget.onClose();
                //     }
                //
                //     if(value == true){
                //       widget.onOpen();
                //     }
                //
                //
                //   },
                //   decoration: BoxDecoration(
                //
                //       gradient : LinearGradient(
                //           colors: [
                //             Colors.grey.shade100,
                //             Colors.grey.shade50,
                //           ]
                //
                //       ),
                //       borderRadius: BorderRadius.vertical(top: Radius.circular(40))
                //   ),
                //
                //   height: value ? MediaQuery.of(context).size.height * .82 : 0,
                //   width: double.infinity,
                //
                //
                //   child: Padding(
                //     padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                //     child: Column(
                //       children: [
                //         Flexible(child: Divider(color: Colors.lightGreen.shade900, thickness: 1,)),
                //
                //         Expanded(
                //           flex: 500,
                //           child: child!,
                //         ),
                //       ],
                //     ),
                //   ),
                // );

              },

              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

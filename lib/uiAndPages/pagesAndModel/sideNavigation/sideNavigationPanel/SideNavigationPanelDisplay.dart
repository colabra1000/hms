import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/sideNavigation/sideNavigationPanel/SideNavigationPanelModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';
import 'package:provider/provider.dart';

class SideNavigationPanelDisplay extends StatefulWidget {

  final Function(SideNavigationPanelModel model) expose;

  const SideNavigationPanelDisplay({Key? key, required this.expose}) : super(key: key);

  @override
  State<SideNavigationPanelDisplay> createState() => _SideNavigationPanelDisplayState();
}

class _SideNavigationPanelDisplayState extends State<SideNavigationPanelDisplay> {

  late SideNavigationPanelModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView<SideNavigationPanelModel>(

        onModelReady: (model) async {
          this.model = model;
          widget.expose(model);

          SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
            model.activate = true;
          });



        },

        builder: (_, model) => Selector(

          selector: (_, SideNavigationPanelModel model) => model.activate,

          builder: (_, bool value, __) {
            return Stack(
              children: [
                AnimatedPositioned(
                  left: value ? 0 :
                  -MediaQuery.of(context).size.width * .8,

                  height: MediaQuery.of(context).size.height,

                  onEnd: (){

                    if(model.activate == false)
                      model.onDeactivate?.call();

                  },



                  duration: Duration(milliseconds: 200),
                    curve: Curves.easeOut,

                    child: SafeArea( 
                      child: ClipRRect(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),

                        child: Container(
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                            color: SharedUi.getColor(ColorType.light2)
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              Container(
                                height: MediaQuery.of(context).size.height * .3,
                                decoration: BoxDecoration(
                                  color: Colors.blue
                                ),

                              ),

                              Container(

                                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: SharedUi.getColor(ColorType.light)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      SharedUi.mSwitch(
                                          label: "Theme",
                                          switchValue: false),
                                      SharedUi.smallText("light Theme", colorType: ColorType.secondary)
                                    ],
                                  )
                                  
                              ),


                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(height: 20,),
                                    _button(label : "Account Information", onTap : (){

                                      model.navigateToAccountInformationPage(context);
                                    }),
                                    SizedBox(height: 20,),
                                    _button(label : "FAQ / Help"),
                                    SizedBox(height: 20,),
                                    _button(label : "About"),
                                  ],
                                ),
                              ),

                            ],
                          ),



                        ),
                      ),
                    ),
                )
              ],
            );
          }
        )
    );

  }


  Widget _button({required String label, Function()? onTap}){
    return   ButtonAnimator1(
      onTap2: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30),
            //     border: Border.all(color: SharedUi.getColor(ColorType.secondary2), width: .8)
            // ),

            child: SharedUi.mediumText(label, maxLine: 1, bold: true, colorType: ColorType.secondary)
        )
    );
  }


}

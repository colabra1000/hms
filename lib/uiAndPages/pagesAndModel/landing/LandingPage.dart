import 'package:c_modal/c_modal.dart';
import 'package:c_ui/c_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/uiAndPages/decorations/BasePageScaffold.dart';
import 'package:hms/uiAndPages/decorations/PageBackgroundDecorator.dart';
import 'package:hms/uiAndPages/documents/LandingPageDocument.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/landing/LandingPageModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/enums.dart';




class LandingPageView extends StatelessWidget {
  LandingPageView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BaseView<LandingPageModel>(
        builder: (context, model)=>

            BasePageScaffold(
              pageTitle: "Home",
              pageIcon: Icon(Icons.home),
                child: CModal(

                controller: model.cModalController,

                child: PageBackGroundDecorator(

                  child: SingleChildScrollView(

                    child: Column(

                      children: [

                        Container(
                          constraints: BoxConstraints(
                              minHeight: 200
                          ),
                          height: MediaQuery.of(context).size.height*.4,

                          width: double.infinity,

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LandingPageDocument.doc1,
                                LandingPageDocument.doc2,

                                Expanded(

                                    child: Container(
                                      margin: EdgeInsets.all(6),

                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.2),
                                        borderRadius: BorderRadius.circular(20)

                                      ),

                                      width: double.infinity,
                                      // color: Colors.grey.shade800,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SharedUi.logo1(),
                                      ),
                                    )
                                )

                              ],
                            ),
                          ),


                        ),

                        Container(

                        


                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(child:
                                      DisplayBox2(title : "Tab 1",
                                        subTitle: "Information about tab 1",
                                        buttonText: "Select" ,
                                        onTap: (){

                                        },),),

                                    Expanded(child: DisplayBox2(
                                      title: "Tab 2",
                                      subTitle: "Information about Tab 2",
                                      buttonText: "Select",
                                      onTap: (){

                                      },
                                    )),

                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(child: DisplayBox2(
                                      title: 'Login',
                                      subTitle: "Log into your Account",
                                      buttonText: "LOGIN!!",
                                      onTap: (){

                                        model.navigateToLoginPage(context);

                                      },
                                    )),
                                    Expanded(
                                        child: Container(
                                          child: DisplayBox2(
                                            title: "Tab 3",
                                            subTitle: "Information about tab 3",
                                            buttonText: "Select",
                                            onTap: () async {

                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * .05,
                          ),
                          color: Colors.grey.shade900,
                          width: double.infinity,
                          child: LandingPageDocument.doc3,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
    );
  }
}



class DisplayBox2 extends StatelessWidget {

  final String title;
  final String subTitle;
  final void Function() onTap;
  final String buttonText;

  DisplayBox2({required this.title, required this.subTitle,
    required this.onTap, required this.buttonText});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(

        child: PhysicalModel(
          color: SharedUi.getColor(ColorType.info),
          elevation: 5,
          borderRadius: BorderRadius.circular(30),
          child: Container(

            constraints: BoxConstraints(
                minHeight: 200
            ),

            height: MediaQuery.of(context).size.height * .26,

            child: AspectRatio(
              aspectRatio: 1,
              child: TextButton(
                onPressed: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SharedUi.normalText(title, colorType: ColorType.divergent),

                      Spacer(),

                      Align(
                          alignment: Alignment.center,
                          child: SharedUi.smallText(subTitle, colorType:ColorType.light,  maxLine: 4)),

                      Spacer(),

                      Container(
                        padding: EdgeInsets.all(10), 
                        decoration: BoxDecoration(
                          color: SharedUi.getColor(ColorType.successLight),
                          borderRadius: BorderRadius.circular(10),

                          // gradient: LinearGradient(
                          //
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //
                          //   colors: [
                          //     SharedUi.getColor(ColorType.infoLight),
                          //     SharedUi.getColor(ColorType.divergent),
                          //   ]
                          // )

                        ),
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.center,
                          child: SharedUi.mediumText(buttonText,

                            colorType: ColorType.outlier,
                            bold: true,
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


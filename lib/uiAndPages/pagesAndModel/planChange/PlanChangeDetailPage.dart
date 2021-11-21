import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/planChange/PlanChangeDetailModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:provider/provider.dart';

class PlanChangeDetailPage extends StatefulWidget {
  const PlanChangeDetailPage({Key? key}) : super(key: key);

  @override
  State<PlanChangeDetailPage> createState() => _PlanChangeDetailPageState();
}

class _PlanChangeDetailPageState extends State<PlanChangeDetailPage> {

  late PlanChangeDetailModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView<PlanChangeDetailModel>(

        onModelReady: (model) async {
          this.model = model;

        },

        builder: (_, model) => Scaffold(
          backgroundColor: SharedUi.getColor(ColorType.light2),
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
                              SharedUi.mediumText("Confirmation"),
                              SharedUi.mButton(
                                height: 3,
                                prepend: Icon(CupertinoIcons.back, size: 15,),
                                edgePads: 20,
                                buttonColorType: ColorType.infoLight,
                                textColorType: ColorType.dark,
                                label: "back",
                                onTap: (){
                                  model.navigateBack(context);
                                }
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child:
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal : 20, vertical: 30),
                          decoration: BoxDecoration(
                            color: SharedUi?.getColor(ColorType.light),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:  Column(
                            children: [

                              Row(
                                children: [
                                  SharedWidgets.profileBox(),
                                  SizedBox(width: 20,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // SharedUi.smallText(model.message!.organisationName ?? "", colorType: ColorType.info),
                                        // SharedUi.smallText(model.message!.subject ?? "", bold: true, maxLine: 2),

                                      ],
                                    ),
                                  ),
                                        // SharedWidgets.indicateItemState(context, model.message!.readStatus),
                                ],
                              ),


                              SizedBox(height: 20,),

                              Column(
                                children: [
                                  _labelValue(label: "Plan Type", value: model.planName),
                                  SizedBox(height: 10,),
                                  _labelValue(label: "Time to Confirmation", value: "${model.timeToConfirmation} hours"),
                                  SizedBox(height: 10,),
                                  _labelValue(label: "Subscription price", value: model.subscriptionPrice),
                                  SizedBox(height: 10,),
                                  _labelValue(label: "attributes", value: model.detailedAttribute),


                                ],
                              ),

                              SizedBox(height: 20,),

                              SharedUi.mediumText("Your selection would be confirmed in the next ${model.timeToConfirmation} hours.", maxLine: 200, letterSpacing: 1, wordSpacing: 3, height: 2, colorType: ColorType.dark),


                              SizedBox(height: 40,),

                              _cancelPlanButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                    ],
                  ),
                )
            )
        )
    );

  }

  Widget _labelValue({required String label, required value,
    ColorType? labelColorType, ColorType? valueColorType}){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: SharedUi.smallText(label, bold: true, colorType: labelColorType ?? ColorType.secondary)),


        Expanded(
            flex: 2,
            child: value is String ?
            SharedUi.smallText(value, bold: true, colorType: valueColorType ?? ColorType.secondary)
            : value is List ?
            Column(children: List.generate(value.length, (index)
              => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SharedUi.smallText("${value[index]}", bold: true, colorType: valueColorType ?? ColorType.secondary),
                  SizedBox(height: 5,)
                ],
              )
            ),) : Container()
        )

      ],
    );
  }


  Widget _cancelPlanButton(){
    return Row(
      children: [
        SharedUi.mButton(
            append: Icon(CupertinoIcons.xmark_circle_fill, size: 25, color: Colors.grey.shade50,),
            label: 'cancel plan selection',
            edgePads: 20, height: 4, buttonColorType: ColorType.danger,
            onTap: (){
              model.navigateBack(context);
              // model.pageModalController.changeModalState = CModalStateChanger(
              //   state: CModalState.custom1,
              //   dismissOnOutsideClick: false,
              //   displayedModal: _deleteAppointmentConfirmationModal(model),
              // );
            }
        ),
      ],
    );
  }

  Widget _loadingIndicator(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

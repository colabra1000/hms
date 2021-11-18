import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/services/AppointmentService.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:provider/provider.dart';
import 'package:hms/uiAndPages/pagesAndModel/appointmentAndChat/appointment/viewAppointment/ViewAppointmentModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:c_modal/c_modal.dart';


class ViewAppointmentPage extends StatefulWidget {
  const ViewAppointmentPage({Key? key}) : super(key: key);

  @override
  State<ViewAppointmentPage> createState() => _ViewAppointmentPageState();
}

class _ViewAppointmentPageState extends State<ViewAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ViewAppointmentModel>(

        onModelReady: (model){
          model.fetchSingleAppointment();
        },

        builder: (_, model)
          => CModal(
                controller: model.pageModalController,
                child: Scaffold(
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
                                SharedUi.mediumText("Appointment"),
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

                        Selector(

                          selector: (_, ViewAppointmentModel model)=> model.appointment,

                          builder: (_, Appointment? value, __) {

                            return value == null ?
                            Expanded(child: Center(child: _loadingIndicator())):

                              Selector(


                                selector: (_, ViewAppointmentModel model)=>model.appointment!.status,

                                builder: (_, int? value2, __) {


                                  return Expanded(
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: SingleChildScrollView(
                                        child: Container(

                                          padding: EdgeInsets.symmetric(horizontal : 20, vertical: 30),
                                          decoration: BoxDecoration(
                                            color: SharedUi?.getColor(ColorType.light),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child:  Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Row(
                                                children: [
                                                  SharedWidgets.profileBox(),
                                                  SizedBox(width: 20,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SharedUi.smallText(model.appointment!.organisationName ?? "", colorType: ColorType.info),

                                                    ],
                                                  ),
                                                  // Spacer(),
                                                  // SharedWidgets.readStatus(model.message!.readStatus ?? ""),
                                                ],
                                              ),

                                              SizedBox(height: 20,),

                                              Column(
                                                children: [
                                                 _labelValue(label: "Booked on", value: HelperService.timeFormat2(model.appointment!.timeBooked)),
                                                  SizedBox(height: 10,),
                                                  _labelValue(label: "Appointment date", value: HelperService.timeFormat2(model.appointment!.timeDue)),
                                                  SizedBox(height: 10,),
                                                  _labelValue(label: "Due in", value: model.dueDays()),
                                                  SizedBox(height: 10,),
                                                  _labelValue(label: "Status", value: model.appointmentStatusName, valueColorType:
                                                  AppointmentService.getAppointmentStatusColor(model.appointmentStatus)),

                                                ],
                                              ),

                                              SizedBox(height: 20,),

                                              SharedUi.mediumText(model.narrateAppointment, maxLine: 200, letterSpacing: 1, wordSpacing: 3, height: 2, colorType: ColorType.dark),
                                              SizedBox(height: 40,),



                                              _cancelRemoveButton(model),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );


                                }
                            );
                          }
                        ),


                      ],
                    ),
                  )
              )
          ),
            ),
    );
  }

  Widget _deleteAppointmentConfirmationModal(ViewAppointmentModel model){
    return SharedWidgets.modalScaffold(context,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SharedUi.mediumText(
                  model.appointmentStatus == AppointmentService.CANCELLED ? "Remove this appointment" :
                  "Are you sure you want to cancel appointment at ${model.appointment!.organisationName}",
                  alignment: TextAlign.center,
                  height: 2,
                  bold: true,
                  colorType: ColorType.dark, maxLine: 50),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * .12,),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[

                  SharedUi.mButton(label: "Yes",
                      buttonColorType: ColorType.danger,
                      edgePads: 35, height: 3,
                      onTap: (){

                        model.cancelOrRemoveAppointment(context);
                        // model.appointmentStatus == ViewAppointmentModel.CANCELLED

                        // model.deleteAppointment(appointment);
                        // model.pageModalController.dismissModal();
                      }
                  ),




                  SharedUi.mButton(
                      label: "No", height: 3, textColorType: ColorType.dark,
                      edgePads: 40, buttonColorType: ColorType.dark2,
                      onTap: (){
                        model.pageModalController.dismissModal();
                      }
                  ),

                ]
            ),

            SizedBox(height: 40,)

          ],
        )
    );
  }

  Widget _labelValue({required String label, required String value,
    ColorType? labelColorType, ColorType? valueColorType}){
    return  Row(
      children: [
        Expanded(flex: 3, child: SharedUi.smallText(label, bold: true, colorType: labelColorType ?? ColorType.secondary)),
        Expanded(
          flex: 2,
            child: Align(alignment: Alignment.centerLeft, child: SharedUi.smallText(value, bold: true, colorType: valueColorType ?? ColorType.secondary))
        ),

      ],
    );
  }

  Widget _cancelRemoveButton(ViewAppointmentModel model){
    return Row(
      children: [
        SharedUi.mButton(append: Icon(CupertinoIcons.clear, size: 15, color: Colors.grey.shade50,),
            label: model.appointmentStatus == AppointmentService.CANCELLED ?
            "remove" : model.appointmentStatus == AppointmentService.ACCEPTED ||model.appointmentStatus == AppointmentService.PENDING ?
            'cancel Appointment' : "--",
            edgePads: 20, height: 4, buttonColorType: ColorType.danger,
            onTap: (){
              model.pageModalController.changeModalState = CModalStateChanger(
                  state: CModalState.custom1,
                  dismissOnOutsideClick: false,
                  displayedModal: _deleteAppointmentConfirmationModal(model),
              );
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

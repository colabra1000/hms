import 'package:c_modal/src/CModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/services/AppointmentService.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/appointment/AppointmentModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:c_input/c_input.dart';

class AppointmentPanel extends StatefulWidget{

  final CModalController pageModalController;

  const AppointmentPanel(this.pageModalController, {Key? key}) : super(key: key);

  @override
  State<AppointmentPanel> createState() => _AppointmentPanelState();
}

class _AppointmentPanelState extends State<AppointmentPanel>{


  late AppointmentModel model;


  @override
  Widget build(BuildContext context) {
    return BaseView<AppointmentModel>(

        onModelReady: (model){
          this.model = model;
          model.pageModalController = widget.pageModalController;
        },

        builder: (_, model){
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 15),

              decoration: BoxDecoration(
                  color: SharedUi.getColor(ColorType.light2),
                  borderRadius: BorderRadius.circular(20)
              ),

              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Expanded(
                    child: Selector(

                      selector: (_, AppointmentModel model)=> model.appointmentBookingState,

                      builder:(_, AppointmentBookingState value, __){
                        bool bookingAppointment = model.appointmentBookingState != AppointmentBookingState.idle;
                        return Column(
                          children: [


                            Row(
                              children: [

                                    _dualButton(),

                                    Spacer(),

                                    _affirmButton(value),

                              ],
                            ),

                            SizedBox(height: 30,),

                            Expanded(
                              child: Container(

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: SharedUi.getColor(ColorType.faint))
                                ),

                                child: Stack(
                                  children: [

                                    AnimatedSwitcher(
                                        duration:  Duration(
                                            milliseconds: 700
                                        ),

                                      child: !bookingAppointment ?
                                        _appointmentListPanel() :
                                      value == AppointmentBookingState.enterAppointmentNote  ?
                                        _appointmentNote() : _calenderDisplay(),


                                    ),

                                    _topLabel(value),

                                    // _topLabel(value),
                                  ],
                                ),
                              ),
                            )


                          ],
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20,),
                ],
              )
          );
        }
    );
  }


  Widget _topLabel(AppointmentBookingState appointmentBookingState){

    return

      Align(

      alignment: Alignment.topCenter,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blue.shade300.withOpacity(.6),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SharedUi.mediumText(appointmentBookingState == AppointmentBookingState.pickAppointmentDate ?
              "Pick Appointment Date": appointmentBookingState == AppointmentBookingState.enterAppointmentNote ?
              "Enter Note!": appointmentBookingState == AppointmentBookingState.idle ? "My Appointments"
                 : "Confirm Appointment",
                  colorType: ColorType.light
              ),
            ],
          ),
      ),
    );

  }


  Widget _dualButton(){
    bool bookingAppointment = model.appointmentBookingState != AppointmentBookingState.idle;
    return  GestureDetector(
      onTap: (){

        model.appointmentBookingState == AppointmentBookingState.idle ?
        model.appointmentBookingState = AppointmentBookingState.pickAppointmentDate :
        model.appointmentBookingState = AppointmentBookingState.idle;

        model.resetDate();


    },
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: bookingAppointment ? 0 :10),
        width: bookingAppointment ? 36 : 180,
        decoration: BoxDecoration(
            // shape: selected ? BoxShape.circle : BoxShape.rectangle,
            color: bookingAppointment ? SharedUi.getColor(ColorType.error)
                : SharedUi.getColor(ColorType.light),

            border: Border.all(color: SharedUi.getColor(ColorType.dark2)),
            borderRadius:
            bookingAppointment ? BorderRadius.circular(20) :
            BorderRadius.circular(20)
        ),
        child:
        bookingAppointment ? Icon(Icons.close, color: SharedUi.getColor(ColorType.light), size: 25,) :
        SharedUi.smallText("Book Appointment", colorType: ColorType.secondary
        ),
      ),
    );
  }

  Widget _affirmButton(AppointmentBookingState appointmentState){

    bool bookingAppointment = appointmentState != AppointmentBookingState.idle;

    return ButtonAnimator2(
      onTap2: (){
        FocusScope.of(context).unfocus();
        if(appointmentState == AppointmentBookingState.pickAppointmentDate)
          model.appointmentBookingState = AppointmentBookingState.enterAppointmentNote;

        if(appointmentState == AppointmentBookingState.enterAppointmentNote){

          model.setNewAppointment();

          model.pageModalController.changeModalState = CModalStateChanger(
            state: CModalState.custom4,
            dismissOnOutsideClick: true,
            displayedModal: _confirmAppointmentModal(),
            fadeDuration: Duration(milliseconds: 100)

          );

        }
      },

      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(vertical: 5),
        width: bookingAppointment ? 36 : 0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:  SharedUi.getColor(ColorType.success),

          border: Border.all(color: SharedUi.getColor(ColorType.light)),
          borderRadius: null,
        ),
        child:
        bookingAppointment ? Icon(CupertinoIcons.checkmark_alt, color: SharedUi.getColor(ColorType.light), size: 25,):
        SizedBox.shrink(),

      ),
    );


  }


  Widget _appointmentNote(){

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
            child: CTextField(model.appointmentNoteInputController, minLines: 4,),
          ),

          SharedUi.mediumText("Appointment Note!!"),
          SizedBox(height: 40,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SharedUi.mButton(append: Icon(Icons.arrow_back_rounded, color: SharedUi.getColor(ColorType.light),), buttonColorType: ColorType.danger,
                    height: 3, edgePads: 20,
                    onTap: (){

                  model.appointmentBookingState = AppointmentBookingState.pickAppointmentDate;

                }),
              ),
            ],

          ),
          SizedBox(height: 40,),
        ],
      ),
    );

  }


  Widget _confirmAppointmentModal(){

    return SharedWidgets.modalScaffold( context,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,

          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            SizedBox(height: 40,),
            SharedUi.mediumText("Book Appointment with", maxLine: 10, colorType: ColorType.dark, alignment: TextAlign.center),
            SharedUi.mediumText("${model.organisationName}", bold: true, maxLine: 10, colorType: ColorType.dark, alignment: TextAlign.center),
            SharedUi.mediumText("for ${HelperService.timeFormatS(time: model.appointmentDate.toString(), sDatePrefix: " on the ")}", colorType: ColorType.dark, alignment: TextAlign.center),

            SizedBox(height: 20,),

            SharedUi.mediumText("Note: ", maxLine: 10, colorType: ColorType.light),
            SharedUi.smallText(model.appointmentNote, maxLine: 2, colorType: ColorType.light),

            SizedBox(height: 20,),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[

                  SharedUi.mButton(label: "ok",
                      buttonColorType: ColorType.info,
                      edgePads: 35, height: 3,
                      onTap: (){

                        model.addNewAppointment();
                        model.appointmentBookingState = AppointmentBookingState.idle;

                      }
                  ),


                  SharedUi.mButton(
                      label: "cancel", height: 3,
                      edgePads: 18, buttonColorType: ColorType.danger,
                      onTap: (){
                        model.pageModalController.dismissModal();
                      }
                  ),

                ]
            ),


          ],
        ),
    );

  }

  Widget _calenderDisplay(){
    return Selector(

      selector: (_, AppointmentModel model)=>model.appointmentDate,

      builder:(_, DateTime? value, __){

        return SingleChildScrollView( 
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: model.appointmentDate ?? DateTime.now(),
                onDaySelected: (selectedDay, focusedDay) {

                  model.appointmentDate = selectedDay;

                 },

                selectedDayPredicate: (day) {
                  return isSameDay(model.appointmentDate, day);
                },

                availableGestures: AvailableGestures.none,

                // enabledDayPredicate: (DateTime day) => false,

                calendarFormat: model.calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    model.calendarFormat = format;
                  });
                },

                // onPageChanged: (focusedDay) {
                //   model.appointmentDate = focusedDay;
                // },
              ),
          ),
        );
      },
    );
  }

  Widget _appointmentListPanel(){

    return Selector(

      selector: (_, AppointmentModel model)=>model.appointments.length,

      builder: (_, int value, __) {
        return Container(

          child: ListView.builder(
            itemBuilder: (_, int i){

              if(i == 0)
                return Column(
                  children: [
                    SizedBox(height: 30,),
                    _appointmentListItem(i),
                  ],
                );

              return _appointmentListItem(i);
            },

            itemCount: model.appointments.length,

          ),
        );
      }
    );
  }

  Widget _appointmentListItem(int i){

    Appointment appointment = model.appointments[i];

    return ButtonAnimator2(
      onTap2: (){

        model.navigateToViewAppointment(context, appointment);

      },
      child: Selector(
        selector: (_, AppointmentModel model) => (model.appointments[i]).status,

        builder: (_, dynamic value, __) {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),

              decoration: BoxDecoration(
                border: Border.all(color: SharedUi.getColor(AppointmentService.getAppointmentStatusColor(appointment.status))),
                borderRadius: BorderRadius.circular(10),
                color: SharedUi.getColor(ColorType.light2)
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SharedUi.mediumText(appointment.organisationName ?? "", colorType: ColorType.dark),
                  SharedUi.smallText(model.getAppointmentStatus(appointment), colorType: ColorType.secondary),
                ],
              )

          );
        }
      ),
    );
  }

}

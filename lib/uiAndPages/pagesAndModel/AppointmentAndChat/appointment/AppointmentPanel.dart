import 'package:c_modal/src/CModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/services/HelperService.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/appointment/AppointmentModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';

import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';

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

              decoration: BoxDecoration(
                  color: SharedUi.getColor(ColorType.secondary2),
                  borderRadius: BorderRadius.circular(20)
              ),

              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Selector(

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

                          Container(

                            decoration: BoxDecoration(
                                border: Border.all(color: SharedUi.getColor(ColorType.secondary2)),
                                borderRadius: BorderRadius.circular(10),
                                color: SharedUi.getColor(ColorType.faint)
                            ),

                            child: Stack(
                              children: [

                                value == AppointmentBookingState.enterAppointmentNote

                                ?  _appointmentNote()

                                :AnimatedCrossFade(
                                  duration: Duration(
                                      milliseconds: 700
                                  ),
                                  crossFadeState: bookingAppointment ? CrossFadeState.showFirst :
                                  CrossFadeState.showSecond,
                                  firstChild: _calenderDisplay(),
                                  secondChild: _appointmentListPanel(),
                                ),

                                _topLabel(value),
                              ],
                            ),
                          )


                        ],
                      );
                    },
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
              color: Colors.blue.shade300.withOpacity(.6)
          ),
          child: Center(
            child :
            SharedUi.mediumText(appointmentBookingState == AppointmentBookingState.pickAppointmentDate ?
            "Pick Appointment Date": appointmentBookingState == AppointmentBookingState.enterAppointmentNote ?
            "Enter Note!": appointmentBookingState == AppointmentBookingState.idle ? "My Appointments"
               : "Confirm Appointment",
                colorType: ColorType.light
            ),

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

            border: Border.all(color: SharedUi.getColor(ColorType.light)),
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
      onTap: (){
        if(appointmentState == AppointmentBookingState.pickAppointmentDate)
          model.appointmentBookingState = AppointmentBookingState.enterAppointmentNote;

        if(appointmentState == AppointmentBookingState.enterAppointmentNote){

          model.setNewAppointment();

          model.pageModalController.changeModalState = CModalStateChanger(
            state: CModalState.custom4,
            dismissOnOutsideClick: true,
            modalDisplay: _confirmAppointmentModal(),
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

    return Column(
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
              child: SharedUi.mButton("back", buttonColorType: ColorType.error, onTap: (){

                model.appointmentBookingState = AppointmentBookingState.pickAppointmentDate;

              }),
            ),
          ],

        ),
        SizedBox(height: 40,),
      ],
    );

  }


  Widget _confirmAppointmentModal(){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(

          margin: EdgeInsets.symmetric(horizontal: 10),

          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20),
          ),

          height: MediaQuery.of(context).size.height * .5,

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.stretch,

                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  SizedBox(height: 40,),
                  SharedUi.normalText("Book Appointment with", maxLine: 10, colorType: ColorType.divergent),
                  SharedUi.normalText("Dr ${model.doctorName}", bold: true, maxLine: 10, colorType: ColorType.divergent),
                  SharedUi.mediumText("${model.getLongAppointmentDateDescription(model.appointmentDate.toString())}", maxLine: 10, colorType: ColorType.light),

                  SizedBox(height: 20,),

                  SharedUi.mediumText("Note: ", maxLine: 10, colorType: ColorType.light),
                  SharedUi.smallText(model.appointmentNote, maxLine: 2, colorType: ColorType.light),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                        SharedUi.mButton("ok", onTap: (){

                          model.addNewAppointment();
                          model.appointmentBookingState = AppointmentBookingState.idle;

                          model.pageModalController.changeModalState = CModalStateChanger(
                              state: CModalState.none,
                          );

                        }),

                      SharedUi.mButton("cancel", buttonColorType: ColorType.danger, onTap: (){

                        model.pageModalController.changeModalState = CModalStateChanger(
                          state: CModalState.none,
                        );

                      }),
                    ]
                  ),


                ],
              ),
            ),
          ),
        ),
      ],
    );

  }


  Widget _calenderDisplay(){
    return Selector(

      selector: (_, AppointmentModel model)=>model.appointmentDate,

      builder:(_, DateTime? value, __){

        return Padding(
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
        );
      },
    );
  }

  Widget _appointmentListPanel(){

    return Container(

      height: MediaQuery.of(context).size.height * .5,
      constraints: BoxConstraints(
        minHeight: 450
      ),
      child: ListView.builder(
        itemBuilder: (_, int i){
          Appointment appointment = model.appointments[i];

          if(i == 0)
            return Column(
              children: [
                SizedBox(height: 20,),
                _appointmentListItem(appointment),
              ],
            );

          return _appointmentListItem(appointment);
        },

        itemCount: model.appointments.length,

      ),
    );
  }

  Widget _appointmentListItem(Appointment appointment){


    return ButtonAnimator1(
      onTap: (){

        model.pageModalController.changeModalState = CModalStateChanger(
            state: CModalState.custom1,
            modalDisplay: _appointmentListItemDescription(appointment),
            dismissOnOutsideClick: true,
        );

      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),

          decoration: BoxDecoration(
            border: Border.all(color: SharedUi.getColor(ColorType.secondary2)),
            borderRadius: BorderRadius.circular(10),
            color: SharedUi.getColor(ColorType.dark)
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SharedUi.mediumText(appointment.doctorName ?? "", colorType: ColorType.light),
              Row(
                children: [
                  Expanded(child: SharedUi.smallText(appointment.accepted == true ? model.getShortAppointmentDateFormat(appointment.time) : "Pending", colorType: ColorType.light)),
                  Icon(Icons.close_rounded, color: SharedUi.getColor(ColorType.warning),)
                ],
              ),
            ],
          )

      ),
    );
  }

  Widget _appointmentListItemDescription(Appointment appointment){

    String verb = appointment.accepted == false ? "booked" : "have";

    return _modalScaffold(
        child : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 30,),
              SharedUi.mediumText("You $verb an appointment booked with Dr${appointment.doctorName}", maxLine: 10, colorType: ColorType.light),
              SizedBox(height: 30,),
              SharedUi.mediumText("${model.getLongAppointmentDateDescription(appointment.time)}", maxLine: 10, colorType: ColorType.light),
              SizedBox(height: 50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SharedUi.mButton("Dismiss", leadingIcon: Icon(Icons.close_rounded),
                      buttonColorType: ColorType.danger,
                      onTap: (){
                        model.pageModalController.changeModalState = CModalStateChanger(
                          state: CModalState.none,
                          modalDisplay: _appointmentListItemDescription(appointment),
                          dismissOnOutsideClick: true,
                        );
                  }),
                ],
              )


            ],
          ),
        )
    );
  }

  Widget _modalScaffold({required Widget child}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(

          margin: EdgeInsets.symmetric(horizontal: 10),

          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20),
          ),

          height: MediaQuery.of(context).size.height * .5,

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          ),
        ),
      ],
    );
  }

}

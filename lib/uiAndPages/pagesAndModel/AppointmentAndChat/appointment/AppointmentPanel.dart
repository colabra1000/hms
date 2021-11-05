import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Appointment.dart';
import 'package:hms/uiAndPages/pagesAndModel/AppointmentAndChat/appointment/AppointmentModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentPanel extends StatefulWidget{
  const AppointmentPanel({Key? key}) : super(key: key);

  @override
  State<AppointmentPanel> createState() => _AppointmentPanelState();
}

class _AppointmentPanelState extends State<AppointmentPanel> with AutomaticKeepAliveClientMixin<AppointmentPanel>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseView<AppointmentModel>(
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

                    selector: (_, AppointmentModel model)=> model.bookingAppointment,

                    builder:(_, bool value, __)=>
                      Column(
                        children: [
                          Row(
                            children: [

                                  _mButton(selected: value, onTap: (){
                                    model.bookingAppointment = !model.bookingAppointment;
                                  }),

                                  Spacer(),


                                  AnimatedContainer(
                                      curve: Curves.easeOut,
                                      duration: Duration(milliseconds: 500),
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      width: value ? 36 : 0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                          color:  SharedUi.getColor(ColorType.success),

                                          border: Border.all(color: SharedUi.getColor(ColorType.light)),
                                          borderRadius: null,
                                      ),
                                      child:
                                      value ? Icon(CupertinoIcons.checkmark_alt, color: SharedUi.getColor(ColorType.light), size: 25,):
                                      SizedBox.shrink(),

                                  ),

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

                                AnimatedCrossFade(
                                  duration: Duration(
                                      milliseconds: 700
                                  ),
                                  crossFadeState: value ? CrossFadeState.showFirst :
                                  CrossFadeState.showSecond,
                                  firstChild: _calenderDisplay(),
                                  secondChild: _appointmentListPanel(model),
                                ),

                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade300.withOpacity(.6)
                                    ),
                                    child: Center(
                                      child :
                                      SharedUi.mediumText(value ? "Pick Appointment Date":"My Appointments",
                                          colorType: ColorType.light
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )


                        ],
                      ),
                  ),



                  SizedBox(height: 20,),
                ],
              )
          );
        }
    );
  }

  Widget _mButton({required bool selected, required Function() onTap}){
    return  GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: selected ? 0 :10),
        width: selected ? 36 : 180,
        decoration: BoxDecoration(
            // shape: selected ? BoxShape.circle : BoxShape.rectangle,
            color: selected ? SharedUi.getColor(ColorType.danger)
                : SharedUi.getColor(ColorType.light),

            border: Border.all(color: SharedUi.getColor(ColorType.light)),
            borderRadius:
            selected ? BorderRadius.circular(20) :
            BorderRadius.circular(20)
        ),
        child:
        selected ? Icon(Icons.close, color: SharedUi.getColor(ColorType.light), size: 25,) :
        SharedUi.smallText("Book Appointment", colorType: ColorType.secondary
        ),
      ),
    );
  }

  Widget _calenderDisplay(){
    return Column(
      children: [
        SizedBox(height: 20,),
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
        ),
      ],
    );
  }

  Widget _appointmentListPanel(AppointmentModel model){

    return Container(
      height: MediaQuery.of(context).size.height * .5,
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

    return Container(
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
                SharedUi.smallText(appointment.accepted == true ? appointment.time ?? "" : "Pending", colorType: ColorType.light),
                Spacer(),
                Icon(Icons.close_rounded, color: SharedUi.getColor(ColorType.warning),)
              ],
            ),
          ],
        )
    
    );
  }

}

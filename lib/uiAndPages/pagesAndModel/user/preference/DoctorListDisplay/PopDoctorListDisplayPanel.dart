import 'package:c_input/c_input.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Doctor.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/preference/DoctorListDisplay/PopDoctorListDisplayModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';
import 'package:provider/provider.dart';

class PopDoctorListDisplayPanel extends StatefulWidget {

  final AccessDoctorListDisplayController accessDoctorListDisplayController;


  PopDoctorListDisplayPanel(this.accessDoctorListDisplayController, {Key? key}) : super(key: key);

  @override
  State<PopDoctorListDisplayPanel> createState() => _PopDoctorListDisplayPanelState();
}

class _PopDoctorListDisplayPanelState extends State<PopDoctorListDisplayPanel> {




  @override
  Widget build(BuildContext context) {
    return BaseView<PopDoctorListDisplayModel>(

        onModelReady: (model){

          widget.accessDoctorListDisplayController.onOpen = ()=>onOpen(model);
        },


        builder: (context, model){



          return Selector(

            selector: (_, PopDoctorListDisplayModel model)=>model.loading,

            builder: (_, bool value, __)=>AnimatedSwitcher(
                duration: Duration(milliseconds: 800),
                child: model.loading ? _displayLoadingIndicator() :
                    _body(model),
            ),
          );
        },
    );
  }

  void onOpen(PopDoctorListDisplayModel model) async{
      await model.fetchDoctors();

      if(mounted){
        model.loading = false;
      }
  }


  Widget _body(PopDoctorListDisplayModel model){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,),
            child: _searchBar(model),
          ),

          Expanded(child: _displayDoctorsList(model)),

        ],
      ),
    );
  }

  Widget _displayLoadingIndicator(){
    return CircularProgressIndicator();
  }

  Widget _displayDoctorsList(PopDoctorListDisplayModel model){
    return  ListView.builder(
      itemBuilder: (_, int i){
        if(i == model.doctors.length - 1){
          return Column(
            children: [
              _doctorListItemDisplay(doctor : model.doctors[i], model: model, context: context),
              SizedBox(height: 20,)
            ],
          );
        }

        return _doctorListItemDisplay(doctor : model.doctors[i], model: model, context: context);
      },
      itemCount: model.doctors.length,

    );
  }

  Widget _searchBar(PopDoctorListDisplayModel model){

    return CTextField(model.searchInputController,
      prefixIcon: Icon(Icons.search_rounded,
        size: 35, color:SharedUi.getColor(ColorType.info),),
      hintText: "Search...",
    );
  }

  Widget _doctorListItemDisplay({required Doctor doctor, required PopDoctorListDisplayModel model, required BuildContext context}){
    return ButtonAnimator1(

      onTap2: (){
        model.navigateToAppointmentAndChatPage(context, doctor: doctor);
      },

      child: Container(

        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [

            CircleAvatar(

            ),

            SizedBox(width: 10,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SharedUi.mediumText("${doctor.firstName ?? ""} ${doctor.lastName ?? ""}" , colorType: ColorType.dark,),
                  SharedUi.smallText(doctor.jobDescription ?? "", colorType: ColorType.secondary,),
                ],
              ),
            ),

            Spacer(),

            SharedUi.smallText("10:05 am", colorType: ColorType.secondary),
          ],
        ),
      ),
    );
  }
}

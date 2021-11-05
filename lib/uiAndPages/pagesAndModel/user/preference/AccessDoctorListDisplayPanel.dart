import 'package:c_input/c_input.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Doctor.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/preference/AccessDoctorListDisplayModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';
import 'package:provider/provider.dart';

class AccessDoctorListDisplayPanel extends StatefulWidget {

  final AccessDoctorListDisplayController accessDoctorListDisplayController;

  AccessDoctorListDisplayPanel(this.accessDoctorListDisplayController, {Key? key}) : super(key: key);

  @override
  State<AccessDoctorListDisplayPanel> createState() => _AccessDoctorListDisplayPanelState();
}

class _AccessDoctorListDisplayPanelState extends State<AccessDoctorListDisplayPanel> {




  @override
  Widget build(BuildContext context) {
    return BaseView<AccessDoctorListDisplayModel>(

        onModelReady: (model){

          model.panelDisplay = _displayLoadingIndicator();

          widget.accessDoctorListDisplayController.onOpen = ()=>onOpen(model);
        },


        builder: (context, model)=>Selector(

          selector: (_, AccessDoctorListDisplayModel model)=>model.panelDisplay,

          builder: (_, Widget value, __)=>AnimatedSwitcher(
              duration: Duration(milliseconds: 800),
              child: model.panelDisplay
          ),
        ),
    );
  }

  void onOpen(AccessDoctorListDisplayModel model) async{
      await model.fetchDoctors();

      if(mounted){
        model.panelDisplay = _body(model);
      }
  }


  Widget _body(AccessDoctorListDisplayModel model){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0,),
              child: _searchBar(model),
            ),

            _displayDoctorsList(model),

          ],
        ),
      ),
    );
  }

  Widget _displayLoadingIndicator(){
    return Container(
      key: ValueKey<int>(0),
      child: CircularProgressIndicator(),
    );
  }

  Widget _displayDoctorsList(AccessDoctorListDisplayModel model){
    return  Container(
      key: ValueKey<int>(1),
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemBuilder: (_, int i){
          if(i == model.doctors.length - 1){
            return Column(
              children: [
                _doctorListItemDisplay(doctor : model.doctors[i], model: model, context: context),
                SizedBox(height: MediaQuery.of(context).size.height * .7),
              ],
            );
          }

          return _doctorListItemDisplay(doctor : model.doctors[i], model: model, context: context);
        },
        itemCount: model.doctors.length,

      ),

    );
  }

  Widget _searchBar(AccessDoctorListDisplayModel model){
    return CTextField(model.searchInputController,
      prefixIcon: Icon(Icons.search_rounded, size: 35, color:SharedUi.getColor(ColorType.info),),
      hintText: "Search...",
    );
  }

  Widget _doctorListItemDisplay({required Doctor doctor, required AccessDoctorListDisplayModel model, required BuildContext context}){
    return ButtonAnimator1(

      onTap2: (){
        model.navigateToAppointmentAndChatPage(context, doctor: doctor);
      },

      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade50
        ),
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
                  SharedUi.mediumText(doctor.name ?? "", colorType: ColorType.dark,),
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

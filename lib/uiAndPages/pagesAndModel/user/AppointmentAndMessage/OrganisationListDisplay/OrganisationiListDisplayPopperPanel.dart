import 'package:c_input/c_input.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Organisation.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/OrganisationListDisplay/OrganisationListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';
import 'package:provider/provider.dart';

class OrganisationListDisplayPopperPanel extends StatefulWidget {

  final void Function(OrganisationListDisplayPopperModel model) exposeModel;

  OrganisationListDisplayPopperPanel(this.exposeModel, {Key? key}) : super(key: key);

  @override
  State<OrganisationListDisplayPopperPanel> createState() => _OrganisationListDisplayPopperPanelState();
}

class _OrganisationListDisplayPopperPanelState extends State<OrganisationListDisplayPopperPanel> {


  late OrganisationListDisplayPopperModel model;


  @override
  Widget build(BuildContext context) {
    return BaseView<OrganisationListDisplayPopperModel>(

        onModelReady: (model){
          this.model = model;
          widget.exposeModel(model);
        },

        builder: (context, model){

          return Selector(

            selector: (_, OrganisationListDisplayPopperModel model)=>model.organisations,

            builder: (_, List? value, __)=>AnimatedSwitcher(
                duration: Duration(milliseconds: 800),
                child: value == null ? _displayLoadingIndicator() :
                    _body(model),
            ),
          );
        },
    );
  }




  Widget _body(OrganisationListDisplayPopperModel model){
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

  Widget _displayDoctorsList(OrganisationListDisplayPopperModel model){
    return  ListView.builder(
      itemBuilder: (_, int i){
        if(i == model.organisations!.length - 1){
          return Column(
            children: [
              _doctorListItemDisplay(organisation : model.organisations![i],),
              SizedBox(height: 20,)
            ],
          );
        }

        return _doctorListItemDisplay(organisation : model.organisations![i],);
      },
      itemCount: model.organisations!.length,
    );
  }

  Widget _searchBar(OrganisationListDisplayPopperModel model){

    return CTextField(model.searchInputController,
      prefixIcon: Icon(Icons.search_rounded,
        size: 35, color:SharedUi.getColor(ColorType.info),),
      hintText: "Search...",
    );
  }


  Widget _doctorListItemDisplay({required Organisation organisation,}){
    return ButtonAnimator1(

      onTap2: (){
        model.navigateToAppointmentAndChatPage(context, organisation: organisation);
      },

      child: Container(

        padding: const EdgeInsets.symmetric(horizontal:10, vertical: 15),

        margin: const EdgeInsets.symmetric(vertical: 10),

        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
        ),

        child: Row(
          children: [

            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: AspectRatio(
                aspectRatio: 1,
              ),
            ),

            SizedBox(width: 10,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SharedUi.mediumText("${organisation.name ?? ""}" , colorType: ColorType.dark,),
                  SharedUi.smallText("${organisation.city}", colorType: ColorType.secondary,),
                ],
              ),
            ),

            // Spacer(),

            // SharedUi.smallText("10:05 am", colorType: ColorType.secondary),
          ],
        ),
      ),
    );
  }


}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/pageLayouts/pageLayout.dart';
import 'package:hms/uiAndPages/pagesAndModel/sideNavigation/userInformation/UserInformationModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';
import 'package:provider/provider.dart';
import 'package:c_input/c_input.dart';


class UserInformationPage extends StatefulWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  State<UserInformationPage> createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {

  late UserInformationModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView<UserInformationModel>(

        onModelReady: (model) async {
          this.model = model;
          model.initialize();
        },

        builder: (_, model) =>
            PageLayout.layout(
              isLoading: (UserInformationModel model) => model.isLoading,
              onBackPressed: () async {
                model.navigateBack(context);
              },
              titleIcon: Icon(Icons.add_reaction_outlined),
              title: "User Information",
              body: _body()
            )
    );
  }

  Widget _body(){

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Container(

          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal : 20, vertical: 30),
          decoration: BoxDecoration(
            color: SharedUi?.getColor(ColorType.light),
            borderRadius: BorderRadius.circular(20),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SharedUi.normalText("Personal Information", bold: true,),
              SharedUi.mediumText("This is the record we have of you", colorType: ColorType.secondary),

              Row(
                children: [
                  SizedBox(
                      height: 100,
                      child: SharedUi.femaleAvatar()
                  ),

                  Expanded(child: SharedUi.smallText("All changes made would be confirmed within the next 24 hours", colorType: ColorType.danger)),


                ],
              ),

              _valueLabel(label: "Full name", mValue:(UserInformationModel model)=>model.fullName, entity: UserInformationModel.FULL_NAME,
                  valueEditingWidget:()=> Column(
                  children: [
                    CTextField(model.firstNameInputController, hintText: "First name",),
                    SizedBox(height: 10,),
                    CTextField(model.lastNameInputController, hintText: "Last name",),
                  ],
                )
              ),

              _valueLabel(label: "Country of resident", mValue:(UserInformationModel model)=>model.country, entity: UserInformationModel.COUNTRY,
                  valueEditingWidget:()=> Column(
                    children: [
                      CDropDown(model.countries, model.countryInputController, hintText: "country of origin",)
                    ],
                  )
              ),

              _valueLabel(label: "Date of birth", mValue:(UserInformationModel model)=>model.dateOfBirth , entity: UserInformationModel.DOB,
                  valueEditingWidget:()=> Column(
                    children: [
                      CDatePicker(cInputController: model.dobInputController, yearPlus: 0,),
                    ],
                  )
              ),

              _valueLabel(label: "Email", mValue:(UserInformationModel model)=>model.email, entity: UserInformationModel.EMAIL,
                  valueEditingWidget:()=> Column(
                    children: [
                      CTextField(model.emailInputController, hintText: "Email", isEmail: true,),
                    ],
                  )
              ),

              _valueLabel(label: "Gender", mValue:(UserInformationModel model)=>model.gender , entity: UserInformationModel.GENDER,
                  valueEditingWidget:()=> Column(
                    children: [
                      CDropDown(model.genderList, model.genderInputController, hintText: "gender",)
                    ],
                  )
              ),

              _valueLabel(label: "Blood Group", mValue:(UserInformationModel model)=>model.bloodGroup, entity: UserInformationModel.BLOOD_GROUP,
                  valueEditingWidget:()=> Column(
                    children: [
                      CDropDown(model.bloodGroupList, model.bloodGroupInputController, hintText: "bloodGroup",)
                    ],
                  )
              ),

              _valueLabel(label: "GenoType", mValue:(UserInformationModel model)=>model.genotype, entity: UserInformationModel.GENOTYPE,
                  valueEditingWidget:()=> Column(
                    children: [
                      CDropDown(model.genotypeList, model.genotypeInputController, hintText: "genotype",)
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _valueLabel({String? label, String? Function(UserInformationModel)? mValue, required String entity, required Widget? Function() valueEditingWidget,}){

    // mValue is a function that returns the actual value because the value is coming from outside the selector.
    // it would not reload unless we put it in a function.

    int id = model.entityMap[entity];



    return Selector(

      selector: (_, UserInformationModel model)=> model.editFlag[entity],

      builder: (_, editing, __) {

        return Selector(

          selector: (_, UserInformationModel model)=>mValue?.call(model),

            builder: (_, String? value, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                        child:SharedUi.mediumText(label ?? "", bold: true),
                    ),


                    if(editing == false)
                      //edit button
                      ButtonAnimator2(

                        onTap2:(){
                          model.doAction(id: id, actionType: ActionType.editField);
                        },

                        child: Icon(Icons.edit, color: SharedUi.getColor(ColorType.success),)

                    ),


                    if(editing == true)
                      Row(
                        children: [

                          // accept edit button.
                          ButtonAnimator2(

                              onTap2:(){
                                model.doAction(id: id, actionType: ActionType.confirmSetField);
                                model.doAction(id: id, actionType: ActionType.editField);
                              },

                              child:
                              editing == true ?
                              Row(
                                children: [
                                  Icon(CupertinoIcons.check_mark_circled, color: SharedUi.getColor(ColorType.success),),
                                ],
                              ):

                              Icon(Icons.edit, color: SharedUi.getColor(ColorType.success),)

                          ),
                          SizedBox(width: 25,),

                          //reject edit button
                          ButtonAnimator2(

                              onTap2:(){

                                model.doAction(id: id, actionType: ActionType.cancelSetField);
                                model.doAction(id: id, actionType: ActionType.editField);
                              },

                              child: editing == true ?
                              Row(
                                children: [
                                  Icon(CupertinoIcons.xmark_circle_fill, color: SharedUi.getColor(ColorType.danger),),
                                ],
                              ):

                              Icon(Icons.edit, color: SharedUi.getColor(ColorType.success),)

                          ),
                        ],
                      )

                  ],
                ),

                Container(
                  width: double.infinity,
                  child: AnimatedCrossFade(
                    crossFadeState: editing == true ?
                    CrossFadeState.showFirst : CrossFadeState.showSecond,
                    firstChild: valueEditingWidget.call() ?? SharedUi.smallText("editing"),
                    secondChild: SharedUi.smallText(value ?? "", colorType: ColorType.secondary),
                    duration: Duration(milliseconds: 200),
                  ),
                ),


                if(model.doAction(id: id, actionType: ActionType.checkIfValueHasChanged))
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonAnimator2(
                      onTap2: ()=>model.doAction(id: id, actionType: ActionType.revertChange),
                      child: Container(
                        child: SharedUi.smallText("revert change", colorType: ColorType.danger),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30,),

              ],
            );
          }
        );
      }
    );
  }


}

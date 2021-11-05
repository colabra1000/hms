import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';


class PreferenceTab extends StatelessWidget {

  final UserModel model;

  PreferenceTab({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(height: 50,),
          Align(
              alignment: Alignment.centerLeft,
              child: SharedUi.normalText("Preferences", colorType:ColorType.outlier,)),
          SizedBox(height: 50,),
          Expanded(
              child: Column(
                children: [
                  _mListTile(context,
                      label: "Access Doctor",
                      icon: Icon(Icons.supervisor_account, size: 50, color: SharedUi.getColor(ColorType.light),),
                      onTap2: (){
                        model.openChangeDoctorPopper();
                      }

                  ),

                  _mListTile(context, label: "Update Information",
                      icon: Icon(Icons.system_update_tv, size: 50, color: SharedUi.getColor(ColorType.light),),
                      onTap2: (){
                        model.openUpdateInformationPopper();
                      }
                  ),
                  _mListTile(context, label: "Update Plan",
                      icon: Icon(Icons.next_plan_outlined, size: 50, color: SharedUi.getColor(ColorType.light))),
                ],
              )
          )
        ],
      ),
    );
  }



  Widget _mListTile(BuildContext context, {required String label, required Icon icon, Function()? onTap, Function()? onTap2}){

    return ButtonAnimator1(
      onTap: onTap, onTap2: onTap2,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            // color: Colors.grey.shade100.withOpacity(.6),
          border: Border.all(color: SharedUi.getColor(ColorType.divergent)),
            borderRadius: BorderRadius.circular(10)
        ),

        width: MediaQuery.of(context).size.width * .8,

        child: Row(
          children: [
            SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            ),
            SizedBox(width: 10,),

            Expanded(
                child: SharedUi.mediumText(label, colorType:ColorType.light, minLine: 2)
            ),

          ],
        ),
      ),
    );

  }
}
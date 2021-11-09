import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/UserModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator2.dart';


class PreferenceTab extends StatelessWidget {

  final UserModel model;

  PreferenceTab({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: _lowerButton(
                onTap: (){},
                color: SharedUi.getColor(ColorType.success),
                icon: Icon(CupertinoIcons.heart),
                label: "Tab one\nto be added\n..."
            )
        ),

        SizedBox(width: 20,),

        Expanded(
            child: _lowerButton(
                onTap: (){
                  model.openSelectDoctorPopper();
                },
                color: SharedUi.getColor(ColorType.divergent),
                icon: Icon(Icons.add_comment_outlined, color: SharedUi.getColor(ColorType.outlier),),
                label: "Book Appointment\nAnd Chat with a\nDoctor"
            )
        ),


      ],
    );
  }

  Widget _lowerButton({required Color color, required Icon icon, required String label, Function()? onTap}){

    return ButtonAnimator2(
      onTap2: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: SharedUi.getColor(ColorType.infoLight)),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(.1),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color,
                ),
                child: icon,
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                    child: SharedUi.mediumText(
                        label, maxLine: 5,
                        colorType: ColorType.outlier
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
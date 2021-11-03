import 'package:c_input/c_input.dart';
import 'package:c_modal/c_modal.dart';
import 'package:c_ui/c_ui.dart';
import 'package:flutter/material.dart';
import 'package:hms/uiAndPages/Shared/SharedUi.dart';
import 'package:hms/uiAndPages/decorations/BasePageScaffold.dart';
import 'package:hms/uiAndPages/decorations/PageBackgroundDecorator.dart';
import 'package:hms/uiAndPages/decorations/PageDecorator3.dart';
import 'package:hms/uiAndPages/pagesAndModel/Base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/login/LoginDisplayModel.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';


class LoginDisplayPage extends StatelessWidget {
  const LoginDisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginDisplayModel>(

        builder: (context, model)=>CModal(

          controller: model.cModalController,


          child: BasePageScaffold(
              pageTitle: "Login",
              child: PageBackGroundDecorator(
                  child:  PageDecorator3(

                    header: Column(
                      children: [

                        Container(
                            constraints: BoxConstraints(
                                minHeight: 90
                            ),
                            height: MediaQuery.of(context).size.height * .2,
                            child: SharedUi.logo1()),

                        CText("Login to your Account"),

                      ],
                    ),

                    body: Container(
                      constraints: BoxConstraints(
                        minHeight: 300,
                      ),

                      child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              SizedBox(height: 20,),

                              CText("User Name",),

                              CTextField(model.userNameInputController, hintText: "UserName"),

                              SizedBox(height: 20,),

                              CText("Password",),

                              CTextField(model.passwordInputController, hintText: "Password", isPassword: true,),


                              SizedBox(height: 30,),

                              SharedWidgets.continueButtonWarningBlock(listenTo: (LoginDisplayModel model) =>
                              model.confirmValidation,),

                              Row(
                                children: [
                                  SharedUi.successButton([Icon(Icons.login, color: Colors.grey.shade50,), "Login"],
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    onTap: ()async{

                                      model.setInputFields();

                                            //validate input fields.
                                            if(model.validateInputFields()){
                                              model.confirmValidation = true;


                                            }else{
                                              model.confirmValidation = false;
                                            }



                                    }
                                  ),
                                ],
                              ),

                              SharedUi.vFooterSpace(),

                            ],
                          )

                      ),

                    ),




                    footer:Container(
                      child: Column(
                        children: [
                          CText("Don't have an Account?"),
                          TextButton(
                              onPressed: (){
                              },
                              child: CText("REGISTER", color: Colors.blue,)
                          ),

                          SharedUi.vFooterSpace(),

                        ],
                      ),
                    ),
                  )
              )
          ),
        )

    );
  }
}

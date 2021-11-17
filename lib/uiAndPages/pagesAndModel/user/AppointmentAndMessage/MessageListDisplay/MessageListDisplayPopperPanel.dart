import 'package:c_input/c_input.dart';
import 'package:flutter/material.dart';
import 'package:hms/enums.dart';
import 'package:hms/models/Message.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseView.dart';
import 'package:hms/uiAndPages/pagesAndModel/user/AppointmentAndMessage/MessageListDisplay/MessageListDisplayPopperModel.dart';
import 'package:hms/uiAndPages/shared/SharedUi.dart';
import 'package:hms/uiAndPages/shared/SharedWidget.dart';
import 'package:hms/uiAndPages/shared/ui/ButtonAnimator1.dart';
import 'package:provider/provider.dart';

class MessageListDisplayPopperPanel extends StatefulWidget {

  final void Function(MessageListDisplayPopperModel model) exposeModel;


  MessageListDisplayPopperPanel(this.exposeModel, {Key? key}) : super(key: key);

  @override
  State<MessageListDisplayPopperPanel> createState() => _MessageListDisplayPopperPanelState();
}

class _MessageListDisplayPopperPanelState extends State<MessageListDisplayPopperPanel> {


  late MessageListDisplayPopperModel model;


  @override
  Widget build(BuildContext context) {
    return BaseView<MessageListDisplayPopperModel>(

        onModelReady: (model){

          this.model = model;
          widget.exposeModel(model);

        },


        builder: (context, model){

          return Selector(

            selector: (_, MessageListDisplayPopperModel model)=>model.messages,

            builder: (_, List? value, __)=>AnimatedSwitcher(
                duration: Duration(milliseconds: 800),
                child: value == null ? _displayLoadingIndicator() :
                    _body(model),
            ),
          );
        },
    );
  }



  Widget _body(MessageListDisplayPopperModel model){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,),
            child: _searchBar(),
          ),

          Expanded(child: _messageListPanel(model)),

        ],
      ),
    );
  }

  Widget _displayLoadingIndicator(){
    return CircularProgressIndicator();
  }

  Widget _messageListPanel(MessageListDisplayPopperModel model){

    return  ListView.builder(
      itemBuilder: (_, int i){
        if(i == model.messages!.length - 1){
          return Column(
            children: [
              _messageListItem(index : i, context: context),
              SizedBox(height: 20,)
            ],
          );
        }

        return _messageListItem(index : i, context: context);
      },
      itemCount: model.messages!.length,

    );
  }

  Widget _searchBar(){

    return CTextField(model.searchInputController,
      prefixIcon: Icon(Icons.search_rounded,
        size: 35, color:SharedUi.getColor(ColorType.info),),
      hintText: "Search...",
    );
  }

  Widget _messageListItem({required int index, required BuildContext context}){

    Message message = model.messages![index];

    return ButtonAnimator1(

      onTap2: (){
        model.navigateToMessagePage(context, message: message);
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

            SharedWidgets.profileBox(),

            SizedBox(width: 10,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SharedUi.mediumText("${message.organisationName ?? ""}" , colorType: ColorType.dark,),
                  SharedUi.smallText(message.subject ?? "", colorType: ColorType.secondary,),
                ],
              ),
            ),

           Selector(
             selector: (_, MessageListDisplayPopperModel model) => (model.messages![index] as Message).readStatus,
             builder: (_, int? value, __) {
               return SharedWidgets.indicateItemState(context, value);
             }
           ),
            
          ],
        ),
      ),
    );
  }







}

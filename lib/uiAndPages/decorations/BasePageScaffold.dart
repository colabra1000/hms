import 'package:c_ui/c_ui.dart';
import 'package:flutter/material.dart';


class BasePageScaffold extends StatelessWidget {

  final String? pageTitle;
  final Icon? pageIcon;
  final Widget child;

  const BasePageScaffold({Key? key,this.pageIcon, this.pageTitle, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade200,
          title: Row(
            children: [
              if(pageIcon != null)pageIcon!,

              CText(pageTitle ?? "", color: Colors.grey.shade50, maxLine: 1, overflow: TextOverflow.ellipsis, size: 22, fontWeight: FontWeight.w600,),
            ],
          ),
        ),

        body: Builder(
          builder: (context) {
            return child;
          }
        ),
      ),
    );
  }
}

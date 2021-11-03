import 'package:flutter/material.dart';

class PageDecorator3 extends StatelessWidget {

  final Widget? header;
  final Widget? header2;
  final Widget body;
  final Widget? bottom;
  final Widget? footer;



  const PageDecorator3({Key? key, this.header, this.header2, this.bottom, required this.body, this.footer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,


        children: [


          header ??   Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              alignment: Alignment.centerLeft,

              constraints: BoxConstraints(
                  maxHeight: 140
              ),
              child: Image(image : AssetImage(
                  "assets/images/cac-Logo2.png")),
            ),
          ),

          if(header2 != null)
            header2!,

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Material(
                borderRadius:BorderRadius.all(Radius.circular(10)),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          minHeight: 350
                        ),

                        child: body,
                      ),

                      if(bottom != null)
                        bottom!,

                    ],
                  ),
                ),
              ),
          ),

          SizedBox(height: 50,),

         footer ?? Container(),

          // Spacer(flex: 1,)
        ],
      ),
    );
  }
}

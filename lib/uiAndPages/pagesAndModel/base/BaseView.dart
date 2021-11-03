
import 'package:flutter/cupertino.dart';
import 'package:hms/locator.dart';
import 'package:hms/uiAndPages/pagesAndModel/base/BaseModel.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {

  final Widget Function(BuildContext context, T model) builder;
  final Function(T)? onModelReady;
  // final Widget Function(T)? buildChild;


  BaseView({Key? key, required this.builder, this.onModelReady,}) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {

  T model = locator<T>();

  @override
  void initState() {
    if(widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(

        create: (context) => model,
        builder: (context, child){
          return child!;
        },
        child: widget.builder(context, model),
    );
  }
}

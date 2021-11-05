import 'package:date_format/date_format.dart';

class HelperService{

  static String formatTime(String? time){
    if(time == null) return "";

    try{
      return formatDate(DateTime.parse(time), [HH, ':', nn,]);

    }catch(e){
      return "";
    }
  }


}
import 'package:date_format/date_format.dart';

class HelperService{

  static String? _timeLiteral(String time){
    try{
      DateTime dateTime = DateTime.parse(time);
      DateTime now = DateTime.now();
      if(now.difference(dateTime).inDays == 1){
        return "yesterday";
      }

      if(now.difference(dateTime).inDays == -1){
        return "tomorrow";
      }

      if(now.difference(dateTime).inDays == 0){
        return "today";
      }
    }catch(e){
      return null;
    }

    return null;
  }

  static String formatTime(String? time){

    if(time == null) return "";

    try{
      return formatDate(DateTime.parse(time), [HH, ':', nn,]);

    }catch(e){
      return "";
    }
  }

  static String timeFormat2(String? time) {
    if(time == null) return "";

    try{
      String? timeLiteral = _timeLiteral(time);
     if(timeLiteral != null) return timeLiteral;

      return formatDate(DateTime.parse(time), [d, '-', M, ' ',yy]);

    }catch(e){
      return "";
    }
  }



  static String timeFormatS({String? time, String? sDatePrefix}) {
    if(time == null) return "";
    try{

      String? timeLiteral = _timeLiteral(time);
      if(timeLiteral != null) return timeLiteral;

      return formatDate(DateTime.parse(time) , ["${sDatePrefix ?? ""}", DD," ",d,"'th of ", MM, ", ", yyyy,]);

    }catch(e){
      return "";
    }

  }



}
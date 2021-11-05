import 'package:date_format/date_format.dart';

class HelperService{

  static String formatTime(String time){
    return formatDate(DateTime.parse(time), [HH, ':', nn,]);
  }


}
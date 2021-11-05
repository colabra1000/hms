class Appointment{

  int? doctorId;
  String? doctorName;
  String? time;
  bool? accepted;
  String? message;

  Appointment();

  Appointment.fromJson(Map json){
    doctorId = json["doctorId"];
    doctorName = json["doctorName"];
    time = json["time"];
    accepted = json["accepted"];
    message = json["message"];
  }

  List toList(List? jsonList){
    return jsonList?.map((e) => Appointment.fromJson(e)).toList() ?? [];
  }



}
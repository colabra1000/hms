class Appointment{

  int? organisationId;
  String? organisationName;
  String? time;
  bool? accepted;
  String? message;

  Appointment();

  Appointment.fromJson(Map json){
    organisationId = json["organisationId"];
    organisationName = json["organisationName"];
    time = json["time"];
    accepted = json["accepted"];
    message = json["message"];
  }

  List toList(List? jsonList){
    return jsonList?.map((e) => Appointment.fromJson(e)).toList() ?? [];
  }



}
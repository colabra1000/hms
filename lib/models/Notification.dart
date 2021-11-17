class Notification{

  int? id;
  // String? type;
  int? typeId;
  int? payloadId;
  int? organisationId;
  String? organisationName;
  String? time;


  Notification.fromJson(Map json){
    id = json['id'];
    // type = json['type'];
    payloadId = json['payloadId'];
    typeId = json['typeId'];
    organisationId = json['organisationId'];
    organisationName = json['organisationName'];
    time = json['time'];

  }

  Notification();


  List<Notification> toList(List jsonData){
    return jsonData.map((e) => Notification.fromJson(e)).toList();
  }

}
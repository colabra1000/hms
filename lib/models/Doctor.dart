class Doctor{

  int? id;
  String? firstName;
  String? lastName;
  String? jobDescription;

  Doctor.fromJson(Map json){
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    jobDescription = json['jobDescription'];
  }

  Doctor();

  List<Doctor> toList(List jsonData){
    return jsonData.map((e) => Doctor.fromJson(e)).toList();
  }

}
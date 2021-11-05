class Doctor{

  String? firstName;
  String? lastName;
  String? jobDescription;

  Doctor.fromJson(Map json){
    firstName = json['firstName'];
    lastName = json['lastName'];
    jobDescription = json['jobDescription'];
  }

  Doctor();

  List<Doctor> toList(List jsonData){
    return jsonData.map((e) => Doctor.fromJson(e)).toList();
  }

}
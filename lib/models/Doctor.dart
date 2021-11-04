class Doctor{

  String? name;
  String? jobDescription;

  Doctor.fromJson(Map json){
    name = json['name'];
    jobDescription = json['jobDescription'];
  }

  Doctor();

  List<Doctor> toList(List jsonData){
    return jsonData.map((e) => Doctor.fromJson(e)).toList();
  }

}
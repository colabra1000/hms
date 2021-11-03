
class LoginRequest{

  String? userName;
  String? password;

  LoginRequest();

  Map toJson(){
    return {
      "userName" : userName,
      "password" : password,
    };
  }


}

class ErrorService{

  String getErrorMessageFrom(dynamic errorObject){
    if(errorObject is String){
      return errorObject;
    }

    return "error";
  }


}
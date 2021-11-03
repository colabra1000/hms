

class ValidationService{

  bool validate(List<bool?> validationPool){

    bool validated = true;

    for(int i = 0; i < validationPool.length; i++){
      if(validationPool[i] == null || validationPool[i] == false){
        validated = false;
      }
    }
    return validated;
  }

}
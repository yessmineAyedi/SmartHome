String errorConvertor(String? errorMessage){
  if(errorMessage != null){
    if(errorMessage.contains('A user with that username already exists')){
      return 'A user with that username already exists';
    }else if(errorMessage.contains('No active account found with the given credentials')){
      return 'No active account found with the given credentials';
    }
  }

  return 'Error in sending data';
}
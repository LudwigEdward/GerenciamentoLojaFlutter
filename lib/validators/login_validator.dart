import 'dart:async';

class LoginValidator {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email,sink){
      if(email.contains("@")){
        sink.add(email);
      }else{
        sink.addError("Insira um email válido");
      }
    }
  );

  final validatePassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      if(password.length>6){
        sink.add(password);
      }else{
        sink.addError("Insira uma senha com 6 digitos no mínino");
      }
    }
  );

}
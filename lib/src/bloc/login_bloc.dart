import 'dart:async';

import 'package:crud_firebase_app/src/bloc/validators.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar los datos del stream
  Stream<String> get getEmailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get getPasswordStream =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get getFormValidStream => CombineLatestStream.combine2(
      getEmailStream, getPasswordStream, (email, password) => true);

  //Insertar datos al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtiene el ultimo valor ingresado al stream
  String get getEmail => _emailController.value;
  String get getPassword => _passwordController.value;

  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}

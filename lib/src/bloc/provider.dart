import 'package:flutter/material.dart';

import 'package:crud_firebase_app/src/bloc/login_bloc.dart';
export 'package:crud_firebase_app/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) _instancia = Provider._(key, child);

    return _instancia;
  }

  Provider._(Key key, Widget child) : super(key: key, child: child);

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  @override
  bool updateShouldNotify(Provider old) => loginBloc != old.loginBloc;
}

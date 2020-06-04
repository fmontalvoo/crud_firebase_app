import 'package:flutter/material.dart';

import 'package:crud_firebase_app/src/bloc/login_bloc.dart';
export 'package:crud_firebase_app/src/bloc/login_bloc.dart';

import 'package:crud_firebase_app/src/bloc/product_bloc.dart';
export 'package:crud_firebase_app/src/bloc/product_bloc.dart';

class Provider extends InheritedWidget {
  final _loginBloc = LoginBloc();
  final _productBloc = ProductBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) _instancia = Provider._(key, child);

    return _instancia;
  }

  Provider._(Key key, Widget child) : super(key: key, child: child);

  static Provider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>();
  }

  @override
  bool updateShouldNotify(Provider old) =>
      _loginBloc != old._loginBloc || _productBloc != old._productBloc;

  LoginBloc get getLoginBloc => _loginBloc;
  ProductBloc get getProductBloc => _productBloc;
}

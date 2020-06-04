import 'package:flutter/material.dart';
import 'package:crud_firebase_app/src/utils/utils.dart';
import 'package:crud_firebase_app/src/bloc/provider.dart';
import 'package:crud_firebase_app/src/providers/user_provider.dart';

class LoginPage extends StatelessWidget {
  final UserProvider _provider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[_fondo(context), _form(context)],
      ),
    );
  }

  Widget _form(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: size.height * .28)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            width: size.width * .85,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Login', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _inputEmail(bloc.getLoginBloc),
                SizedBox(height: 30.0),
                _inputPassword(bloc.getLoginBloc),
                SizedBox(height: 30.0),
                _btnIngresar(bloc.getLoginBloc)
              ],
            ),
          ),
          FlatButton(
              child: Text('¿No tienes una cuenta? Registrate'),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'register')),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _inputEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.getEmailStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                  hintText: 'ejemplo@email.com',
                  labelText: 'Correo electrónico',
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _inputPassword(LoginBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.getPasswordStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                  labelText: 'Contraseña',
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  Widget _btnIngresar(LoginBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.getFormValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
                child: Text('Ingresar'),
              ),
              color: Colors.deepPurple,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 0.0,
              onPressed:
                  !snapshot.hasData ? null : () => _login(context, bloc));
        });
  }

  void _login(BuildContext context, LoginBloc bloc) async {
    final response = await _provider.login(bloc.getEmail, bloc.getPassword);
    if (response['success'])
      Navigator.pushReplacementNamed(context, 'home');
    else
      showMessage(context, "Correo o contraseña incorrectos");
  }

  Widget _fondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var gradient = Container(
      height: size.height * .4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circulo = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, .1)),
    );

    return Stack(
      children: <Widget>[
        gradient,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Center(
          child: Container(
              padding: EdgeInsets.only(top: size.height * .1),
              child: Column(
                children: <Widget>[
                  Icon(Icons.person_pin_circle,
                      color: Colors.white, size: 100.0),
                  SizedBox(height: 10.0),
                  Text('Frank Montalvo Ochoa',
                      style: TextStyle(color: Colors.white, fontSize: 25.0))
                ],
              )),
        )
      ],
    );
  }
}

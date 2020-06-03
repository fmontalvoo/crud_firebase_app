import 'package:flutter/material.dart';

bool isNumber(String numero) {
  if (numero.isEmpty) return false;

  if (num.tryParse(numero) == null) return false;

  return true;
}

void showMessage(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(mensaje),
            actions: <Widget>[
              FlatButton(
                  child: Text("Aceptar"),
                  onPressed: () => Navigator.pop(context))
            ],
          ));
}

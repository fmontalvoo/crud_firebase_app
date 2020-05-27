import 'package:crud_firebase_app/src/models/producto_model.dart';
import 'package:crud_firebase_app/src/providers/producto_provider.dart';
import 'package:flutter/material.dart';
import 'package:crud_firebase_app/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _provider = ProductoProvider();

  ProductoModel _producto = ProductoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _txtNombre(),
              _txtPercio(),
              _swtDisponible(),
              _btnGuardar()
            ],
          ),
        ),
      ),
    );
  }

  Widget _txtNombre() {
    return TextFormField(
      initialValue: _producto.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: "Nombre"),
      validator: (value) =>
          value.length < 3 ? 'Debe poseer mas de tres caracteres' : null,
      onSaved: (value) => _producto.nombre = value,
    );
  }

  Widget _txtPercio() {
    return TextFormField(
      initialValue: _producto.precio.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: "Precio"),
      validator: (value) =>
          utils.isNumber(value) ? null : 'Debe ingresar solo numeros',
      onSaved: (value) => _producto.precio = double.parse(value),
    );
  }

  Widget _swtDisponible() {
    return SwitchListTile(
      value: _producto.disponible,
      title: Text('Disponible'),
      onChanged: (value) {
        setState(() {
          _producto.disponible = value;
        });
      },
    );
  }

  Widget _btnGuardar() {
    return RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.deepPurple,
        textColor: Colors.white,
        label: Text('Guardar'),
        icon: Icon(Icons.save),
        onPressed: _submit);
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _provider.crearProducto(_producto);
    }
  }
}

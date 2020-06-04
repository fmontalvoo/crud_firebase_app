import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:crud_firebase_app/src/bloc/provider.dart';
import 'package:crud_firebase_app/src/utils/utils.dart' as utils;
import 'package:crud_firebase_app/src/models/producto_model.dart';

class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _save = false;
  File _imagen;
  ProductBloc _bloc;

  ProductoModel _producto = ProductoModel();

  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of(context).getProductBloc;
    ProductoModel model = ModalRoute.of(context).settings.arguments;
    if (model != null) _producto = model;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: _galeria),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _camara),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _imgImagen(),
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

  Widget _imgImagen() {
    if (_producto.imgURL != null)
      return FadeInImage(
          height: 300.0,
          width: double.infinity,
          fit: BoxFit.contain,
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(_producto.imgURL));

    return _imagen != null
        ? Image.file(_imagen, height: 300.0, fit: BoxFit.cover)
        : Image.asset('assets/img/no_img.png');
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
        onPressed: _save ? null : _submit);
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _save = true;
      });

      if (_imagen != null) _producto.imgURL = await _bloc.subirImagen(_imagen);

      if (_producto.id != null)
        _bloc.editarProducto(_producto);
      else
        _bloc.crearProducto(_producto);
    }
    _snackbar('Registro guardado');
    Navigator.pop(context);
  }

  void _snackbar(String mensaje) {
    final snackbar =
        SnackBar(content: Text(mensaje), duration: Duration(seconds: 2));

    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _galeria() => _loadImage(ImageSource.gallery);
  void _camara() => _loadImage(ImageSource.camera);

  void _loadImage(ImageSource source) async {
    final picked = await ImagePicker().getImage(source: source);
    _imagen = File(picked.path);
    if (_imagen != null) {
      _producto.imgURL = null;
    }
    setState(() {});
  }
}

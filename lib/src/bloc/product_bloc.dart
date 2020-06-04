import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:crud_firebase_app/src/models/producto_model.dart';
import 'package:crud_firebase_app/src/providers/producto_provider.dart';

class ProductBloc {
  final _productController = BehaviorSubject<List<ProductoModel>>();

  final _provider = ProductoProvider();

  Stream<List<ProductoModel>> get getProductStream => _productController.stream;

  void crearProducto(ProductoModel producto) async {
    await _provider.crearProducto(producto);
  }

  void listarProductos() async {
    final productos = await _provider.listarProductos();
    _productController.sink.add(productos);
  }

  void editarProducto(ProductoModel producto) async {
    await _provider.editarProducto(producto);
  }

  void elminarProducto(String id) async {
    await _provider.elminarProducto(id);
  }

  Future<String> subirImagen(File imagen) async {
    final imgURL = await _provider.subirImagen(imagen);
    return imgURL;
  }

  dispose() {
    _productController?.close();
  }
}

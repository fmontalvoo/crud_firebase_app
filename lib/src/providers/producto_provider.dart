import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:crud_firebase_app/src/models/producto_model.dart';

class ProductoProvider {
  static const String URL = 'https://data-base-38d79.firebaseio.com/';

  Future<bool> crearProducto(ProductoModel producto) async{
    final url = '$URL/productos.json';
    final response = await http.post(url, body: productoModelToJson(producto));
    final decode = json.decode(response.body);
    print(decode);
    return true;
  }
}

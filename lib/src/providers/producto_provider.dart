import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:crud_firebase_app/src/utils/keys/keys.dart';
import 'package:crud_firebase_app/src/models/producto_model.dart';
import 'package:crud_firebase_app/src/preferences/user_preferences.dart';

class ProductoProvider {
  static const String URL = DB_URL;
  final _prefs = UserPreferences();

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$URL/productos.json?auth=${_prefs.getToken}';
    final response = await http.post(url, body: productoModelToJson(producto));
    final decode = json.decode(response.body);
    return true;
  }

  Future<List<ProductoModel>> listarProductos() async {
    final url = '$URL/productos.json?auth=${_prefs.getToken}';
    final response = await http.get(url);
    final decode = json.decode(response.body);
    Map<String, dynamic> data = decode;
    List<ProductoModel> productos = List<ProductoModel>();
    data.forEach((key, json) {
      ProductoModel producto = ProductoModel.fromJson(json);
      producto.id = key;
      productos.add(producto);
    });
    return productos;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$URL/productos/${producto.id}.json?auth=${_prefs.getToken}';
    final response = await http.put(url, body: productoModelToJson(producto));
    final decode = json.decode(response.body);
    return true;
  }

  Future<void> elminarProducto(String id) async {
    final url = '$URL/productos/$id.json?auth=${_prefs.getToken}';
    final response = await http.delete(url);
    final decode = json.decode(response.body);
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$CLOUD_NAME/$RESOURCE_TYPE/upload?upload_preset=$UPLOAD_PRESET');

    final mimeType = mime(imagen.path).split('/');
    final uploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    uploadRequest.files.add(file);
    final streamResponse = await uploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Error: ${response.body}');
      return null;
    }

    final decode = json.decode(response.body);
    return decode['secure_url'];
  }
}

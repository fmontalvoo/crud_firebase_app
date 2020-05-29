import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  String id;
  String nombre;
  double precio;
  bool disponible;
  String imgURL;

  ProductoModel({
    this.id,
    this.nombre = '',
    this.precio = 0.0,
    this.disponible = true,
    this.imgURL,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) =>
      new ProductoModel(
        id: json["id"],
        nombre: json["nombre"],
        precio: json["precio"],
        disponible: json["disponible"],
        imgURL: json["imgURL"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "nombre": nombre,
        "precio": precio,
        "disponible": disponible,
        "imgURL": imgURL,
      };
}

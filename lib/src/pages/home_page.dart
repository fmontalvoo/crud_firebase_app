import 'package:crud_firebase_app/src/models/producto_model.dart';
import 'package:flutter/material.dart';

import 'package:crud_firebase_app/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context).getProductBloc;
    bloc.listarProductos();
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: _list(bloc),
      floatingActionButton: _flaotingActionButton(context),
    );
  }

  Widget _list(ProductBloc bloc) {
    return StreamBuilder(
      stream: bloc.getProductStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) =>
                  _item(context, productos[index], bloc));
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _item(BuildContext context, ProductoModel producto, ProductBloc bloc) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      child: GestureDetector(
        child: Card(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: <Widget>[
              (producto.imgURL != null)
                  ? FadeInImage(
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/img/loading.gif'),
                      image: NetworkImage(producto.imgURL))
                  : Image(image: AssetImage('assets/img/no_img.png')),
              ListTile(
                title: Text('${producto.nombre}'),
                subtitle: Text('\$${producto.precio}'),
              )
            ],
          ),
        ),
        onTap: () =>
            Navigator.pushNamed(context, 'product', arguments: producto),
      ),
      onDismissed: (direction) {
        bloc.elminarProducto(producto.id);
      },
    );
  }

  Widget _flaotingActionButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'product'));
  }
}

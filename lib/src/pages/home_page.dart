import 'package:flutter/material.dart';

import 'package:crud_firebase_app/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Container(),
      floatingActionButton: _flaotingActionButton(context),
    );
  }

  Widget _flaotingActionButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'product'));
  }
}

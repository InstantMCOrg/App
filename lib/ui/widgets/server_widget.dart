import 'package:InstantMC/models/server_model.dart';
import 'package:flutter/material.dart';

class ServerWidget extends StatelessWidget {
  final ServerModel _serverModel;
  const ServerWidget(this._serverModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(width: 100, height: 100,),
    );
  }
}

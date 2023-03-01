import 'package:InstantMC/constants/enums/server_status.dart';

class ServerModel {
  final String _id;
  final String _name;
  final String _mcVersion;
  final int _port;
  final int _ramSize;
  final ServerStatus _serverStatus;

  ServerModel(this._id, this._name, this._mcVersion, this._port, this._ramSize,
      this._serverStatus);

  ServerModel.fromJSON(Map<String, dynamic> json) :
        _id = json["server_id"],
        _name = json["name"],
        _mcVersion = json["mc_version"],
        _port = json["port"],
        _ramSize = json["ram_size_mb"],
        _serverStatus = ServerStatus.values.byName(json["status"].toLowerCase());

  ServerStatus get serverStatus => _serverStatus;

  int get ramSize => _ramSize;

  int get port => _port;

  String get mcVersion => _mcVersion;

  String get name => _name;

  String get id => _id;
}
import 'package:InstantMC/constants/enums/server_status.dart';

class Server {
  final String _id;
  final String _name;
  final String _mcversion;
  final int _port;
  final int _ramSize;
  final ServerStatus _serverStatus;

  Server(this._id, this._name, this._mcversion, this._port, this._ramSize,
      this._serverStatus);

  Server.fromJSON(Map<String, dynamic> json) :
        _id = json["server_id"],
        _name = json["name"],
        _mcversion = json["mc_version"],
        _port = json["port"],
        _ramSize = json["ram_size_mb"],
        _serverStatus = ServerStatus.values.byName(json["status"].toLowerCase());
}
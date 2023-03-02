class ServerResourceStatsModel {
  final double _cpuUsagePercent;
  final double _maxMemoryUsageMB;
  final double _memoryUsageMB;
  final DateTime _dateTime;

  ServerResourceStatsModel(
      this._cpuUsagePercent, this._maxMemoryUsageMB, this._memoryUsageMB, {DateTime? dateTime}) : _dateTime = dateTime ?? DateTime.now();

  double get memoryUsageMB => _memoryUsageMB;

  double get maxMemoryUsageMB => _maxMemoryUsageMB;

  double get cpuUsagePercent => _cpuUsagePercent;

  // Time of resource status
  DateTime get dateTime => _dateTime;
}
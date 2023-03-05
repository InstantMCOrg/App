class ServerResourceStatsModel {
  final double _cpuUsagePercent;
  final int _maxMemoryUsageMB;
  final int _memoryUsageMB;
  final DateTime _dateTime;

  ServerResourceStatsModel(
      this._cpuUsagePercent, this._maxMemoryUsageMB, this._memoryUsageMB, {DateTime? dateTime}) : _dateTime = dateTime ?? DateTime.now();

  int get memoryUsageMB => _memoryUsageMB;

  int get maxMemoryUsageMB => _maxMemoryUsageMB;

  double get cpuUsagePercent => _cpuUsagePercent;

  double get memoryUsagePercent => (memoryUsageMB / maxMemoryUsageMB) * 100;

  // Time of resource status
  DateTime get dateTime => _dateTime;
}
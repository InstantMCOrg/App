import 'package:InstantMC/models/server_model.dart';
import 'package:InstantMC/models/server_resource_stats_model.dart';
import 'package:InstantMC/resources/cubits/server_stats/server_stats_cubit.dart';
import 'package:InstantMC/ui/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ServerWidget extends StatelessWidget {
  final ServerModel _serverModel;
  final double _targetHeight = 170;
  final Color _ramUsageColor = const Color.fromRGBO(59, 130, 210, 1.0);
  final Color _cpuUsageColor = const Color.fromRGBO(74, 189, 148, 1.0);

  const ServerWidget(this._serverModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: ColorManager.borderColor,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      color: ColorManager.borderFillColor,
      child: SizedBox(
        height: _targetHeight,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: _buildStatsText(context),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 6,
                child: _buildStatsGraph(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsText(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.titleSmall!;
    return Column(
      children: [
        Text(
          _serverModel.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatTextRow(context, Icons.public, "Port", textStyle),
            Text(
              _serverModel.port.toString(),
              style: textStyle,
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatTextRow(context, Icons.memory, "CPU", textStyle),
            Text(
              "${_serverModel.coreCount} Cores",
              style: textStyle,
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatTextRow(context, Icons.storage, "RAM", textStyle),
            Text(
              "${_serverModel.ramSize} MB",
              style: textStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsGraph(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: ColorManager.borderColor,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        color: ColorManager.borderFillColor,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "RAM",
                      style: TextStyle(
                          color: _ramUsageColor, fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: " + ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "CPU",
                      style: TextStyle(
                          color: _cpuUsageColor, fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: " in %",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
                )),
            Flexible(
              flex: 9,
              child: BlocBuilder<ServerStatsCubit, ServerStatsState>(
                buildWhen: (oldState, newState) =>
                    (newState is ServerStatsSubscribing &&
                        newState.serverModel.id == _serverModel.id) ||
                    (newState is ServerStatsUpdated &&
                        newState.serverModel.id == _serverModel.id),
                builder: (context, state) {
                  final List<ServerResourceStatsModel> data =
                      state is ServerStatsUpdated ? state.stats : [];
                  final chartWidget = SfCartesianChart(
                    margin: const EdgeInsets.all(10.0),
                    primaryXAxis: CategoryAxis(
                      isVisible: false,
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 0.0,
                      maximum: 100.0,
                      interval: 50,
                    ),
                    plotAreaBorderWidth: 0,
                    // we don't want the border on the right side
                    enableAxisAnimation: true,
                    series: <ChartSeries>[
                      // RAM usage
                      LineSeries<ServerResourceStatsModel, String>(
                        animationDuration: 1000, // milliseconds
                          dataSource: data,
                          xValueMapper: (ServerResourceStatsModel data, _) =>
                              data.dateTime.toString(),
                          yValueMapper: (ServerResourceStatsModel data, _) =>
                              data.memoryUsagePercent,
                          color: _ramUsageColor),
                      // CPU usage
                      LineSeries<ServerResourceStatsModel, String>(
                          animationDuration: 1000, // milliseconds
                          dataSource: data,
                          xValueMapper: (ServerResourceStatsModel data, _) =>
                              data.dateTime.toString(),
                          yValueMapper: (ServerResourceStatsModel data, _) =>
                              data.cpuUsagePercent,
                          color: _cpuUsageColor)
                    ],
                  );

                  if (state is ServerStatsSubscribing) {
                    return Stack(
                      children: [
                        Opacity(opacity: 0.3, child: chartWidget),
                        Positioned.fill(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Connecting...",
                            style: Theme.of(context).textTheme.displaySmall,
                            textAlign: TextAlign.center,
                          ),
                        ))
                      ],
                    );
                  }

                  return chartWidget;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTextRow(
      BuildContext context, IconData icon, String title, TextStyle textStyle) {
    final double iconSize = textStyle.fontSize! * 1.3;
    const padding = 5.0;
    return Row(
      children: [
        Icon(
          icon,
          color: ColorManager.white,
          size: iconSize,
        ),
        const SizedBox(
          width: padding,
        ),
        Text(
          title,
          style: textStyle,
        ),
      ],
    );
  }
}

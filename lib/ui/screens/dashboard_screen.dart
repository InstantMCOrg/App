import 'package:InstantMC/constants/ui.dart';
import 'package:InstantMC/resources/cubits/server/server_cubit.dart';
import 'package:InstantMC/ui/widgets/error_widget.dart';
import 'package:InstantMC/ui/widgets/loading_widget.dart';
import 'package:InstantMC/ui/widgets/max_size_container.dart';
import 'package:InstantMC/ui/widgets/server_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/instantmc_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your MC Server"),
      ),
      body: BlocBuilder<ServerCubit, ServerState>(
        builder: (context, state) {
          if (state is ServerDownloading) {
            return const Center(
              child: SizedBox(
                width: kLoadingIconDefaultSize * 1.2,
                height: kLoadingIconDefaultSize * 1.2,
                child: LoadingWidget(subtitle: "Fetching your Server..."),
              ),
            );
          } else if (state is ServerDownloadError) {
            return Center(
              child: MaxSizeContainer(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
                child: InstantMCErrorWidget(
                  state.exception,
                  retryCallback: () => context.read<ServerCubit>().download(),
                ),
              ),
            );
          } else if (state is ServerDownloaded) {
            return ListView.builder(
              itemCount: state.server.length,
              itemBuilder: (context, i) => ServerWidget(
                state.server[i],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

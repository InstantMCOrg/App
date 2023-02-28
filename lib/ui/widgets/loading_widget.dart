import 'package:InstantMC/ui/widgets/instantmc_widget.dart';
import 'package:InstantMC/ui/widgets/max_size_container.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? _subtitle;

  const LoadingWidget({Key? key, String? subtitle})
      : _subtitle = subtitle,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_subtitle == null) {
      return const InstantMCWidget.loading();
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // I don't know why that stuff with flexible works in this case but anyway it works and don't touch it
          const Flexible(flex: 2, child: InstantMCWidget.loading()),
          const SizedBox(
            height: 20,
          ),
          Text(_subtitle!, style: Theme.of(context).textTheme.titleMedium,),
        ],
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class InstantMCWidget extends StatelessWidget {
  final String _animation;
  final String _heroTag = "";

  const InstantMCWidget.loading({Key? key})
      : _animation = "Loading animation",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _heroTag,
      child: RiveAnimation.asset(
        "assets/icon/instantmc_logo.riv",
        animations: [_animation],
      ),
    );
  }
}

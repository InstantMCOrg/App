import 'package:flutter/material.dart';

class MaxSizeContainer extends StatelessWidget {
  final double? maxWidth;
  final double? maxHeight;
  final Widget _child;
  const MaxSizeContainer({Key? key, this.maxWidth, this.maxHeight, required Widget child}) : this._child = child, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity, maxHeight: maxHeight ?? double.infinity),
        child: _child,
      ),
    );
  }
}

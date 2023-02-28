import 'package:InstantMC/resources/exceptions/instantmc_connection_error_exception.dart';
import 'package:flutter/material.dart';

class InstantMCErrorWidget extends StatelessWidget {
  final InstantMCConnectionErrorException _exception;
  final VoidCallback? _retryCallback;
  const InstantMCErrorWidget(this._exception, {Key? key, VoidCallback? retryCallback}) : _retryCallback = retryCallback, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(_exception.message, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
      const SizedBox(height: 20,),
      if(_retryCallback != null) ElevatedButton(onPressed: _retryCallback, child: const Text("Retry"),),
    ],);
  }
}

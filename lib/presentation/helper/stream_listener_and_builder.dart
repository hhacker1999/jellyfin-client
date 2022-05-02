import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/streams.dart';

class StreamListenerAndBuilder<T> extends StatefulWidget {
  final ValueStream<T> stream;
  final void Function(T) listener;
  final Widget Function(BuildContext, T) builder;
  const StreamListenerAndBuilder(
      {Key? key,
      required this.builder,
      required this.listener,
      required this.stream})
      : super(key: key);

  @override
  State<StreamListenerAndBuilder<T>> createState() =>
      _StreamListenerAndBuilderState<T>();
}

class _StreamListenerAndBuilderState<T>
    extends State<StreamListenerAndBuilder<T>> {
  late StreamSubscription<T> _subscription;
  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen((event) {
      widget.listener(event);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget.stream,
      initialData: widget.stream.value,
      builder: (context, AsyncSnapshot<T> snapshot) {
        final T state = snapshot.data as T;
        return widget.builder(context, state);
      },
    );
  }
}

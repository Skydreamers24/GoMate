import 'package:flutter/material.dart';

class SharedData<T> extends StatefulWidget {
  final T? initialData;
  final Widget Function(T?, void Function(T?)) builder;

  const SharedData(
      {super.key, this.initialData, required this.builder});

  @override
  State<SharedData<T>> createState() => _SharedDataState<T>();
}

class _SharedDataState<T> extends State<SharedData<T>> {
  T? sharedData;

  @override
  void initState() {
    sharedData = widget.initialData;
    super.initState();
  }

  void update(T? data) {
    setState(() {
      sharedData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(sharedData, update);
  }
}

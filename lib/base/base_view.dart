import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'after_init.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T)? onModelReady;

  BaseView({required this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>>
    with AfterInitMixin<BaseView<T>> {
  T? model;

  @override
  void didInitState() {
    model = Provider.of<T>(context);
    if (widget.onModelReady != null) {
      widget.onModelReady!(model!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: widget.builder,
    );
  }
}

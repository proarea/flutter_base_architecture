import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/model/request_error.dart';
import 'package:flutter_app/utils/functional_interfaces.dart';

import 'states.dart';

class StateStreamBuilder<TBloc extends BlocBase, T> extends StatelessWidget {
  final Supplier<Stream<StreamState<T>>> streamSupplier;
  final Supplier<Widget> initialWidgetBuilder;
  final SingleFunction<T, Widget> successWidgetBuilder;
  final SingleFunction<RequestError, Widget> failureWidgetBuilder;
  final Runnable reloadCallback;

  const StateStreamBuilder({
    @required this.streamSupplier,
    @required this.reloadCallback,
    this.initialWidgetBuilder,
    this.successWidgetBuilder,
    this.failureWidgetBuilder,
  }) : assert(streamSupplier != null);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StreamState<T>>(
      stream: streamSupplier(),
      builder: (context, snapshot) {
        StreamState<T> state = snapshot.data;
        if (state == null && initialWidgetBuilder != null) {
          return initialWidgetBuilder();
        } else if (state == null ||
            state is LoadingState<T> ||
            (state is SuccessState<T> && successWidgetBuilder == null)) {
          return _buildLoading();
        } else if (state is SuccessState<T> && successWidgetBuilder != null) {
          return successWidgetBuilder(state.data);
        } else if (state is FailureState<T> && failureWidgetBuilder == null) {
          return _buildError(state.failure);
        } else if (state is FailureState<T> && failureWidgetBuilder != null) {
          return failureWidgetBuilder(state.failure);
        } else {
          return initialWidgetBuilder();
        }
      },
    );
  }

  Widget _buildLoading() {
    return CircularProgressIndicator();
  }

  Widget _buildError(RequestError requestError) {
    return Column(
      children: <Widget>[
        Text('${requestError.error}'),
        FlatButton(
          child: Text('Reload'),
          onPressed: reloadCallback,
        )
      ],
    );
  }
}

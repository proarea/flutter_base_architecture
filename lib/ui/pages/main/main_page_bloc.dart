import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_app/api/api_client.dart';
import 'package:flutter_app/architecture/utils/states.dart';
import 'package:flutter_app/storage.dart';
import 'package:flutter_app/utils/functional_interfaces.dart';
import 'package:rxdart/rxdart.dart';

class MainPageBloc extends BlocBase {
  final ApiClient apiClient;

  MainPageBloc(this.apiClient);

  final BehaviorSubject<StreamState<bool>> _dataSubject = BehaviorSubject<StreamState<bool>>();

  BehaviorSubject<StreamState<bool>> get loginSubject => _dataSubject;

  void loadExampleString() {
    callAuthorized(_dataSubject, (token) => apiClient.getExampleString(token));
  }

  void callAuthorized<T>(Subject subject, SingleFunction<String, Future<T>> authCallSupplier) {
    Storage().getToken().then((token) {
      call(subject, () => authCallSupplier(token));
    });
  }

  void call<T>(Subject subject, Supplier<Future<T>> callSupplier) {
    subject.sink.add(LoadingState(true));

    callSupplier().then((value) {
      subject.sink.add(SuccessState(value));
    }).catchError((errorBody) {
      subject.sink.add(FailureState(errorBody));
    });
  }

  @override
  void dispose() {
    _dataSubject.close();
    super.dispose();
  }
}

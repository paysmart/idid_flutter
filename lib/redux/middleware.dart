import 'package:idid_flutter/idid_flutter.dart';
import 'package:redux/redux.dart';

class AuthorizeTransactionMiddleware<T> extends MiddlewareClass<T> {
  @override
  call(Store<T> store, action, next) async {
    await IdidFlutter.authorize(action.toJson());
    next(action);
    return;
  }
}

class ProvisionMiddleware<T> extends MiddlewareClass<T> {
  @override
  call(Store<T> store, action, next) async {
    await IdidFlutter.provision(action.toJson());
    next(action);
    return;
  }
}

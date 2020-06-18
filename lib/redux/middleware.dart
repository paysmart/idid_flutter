import 'package:idid_flutter/idid_flutter.dart';
import 'package:idid_flutter/redux/actions.dart';
import 'package:redux/redux.dart';

class _AuthorizeTransactionMiddleware<T> extends MiddlewareClass<T> {
  @override
  call(Store<T> store, action, next) async {
    await IdidFlutter.authorize(action.toJson());
    next(action);
    return;
  }
}

class _ProvisionMiddleware<T> extends MiddlewareClass<T> {
  @override
  call(Store<T> store, action, next) async {
    await IdidFlutter.provision(action.toJson());
    next(action);
    return;
  }
}

class _IsProvisionedMiddleware<T> extends MiddlewareClass<T> {
  @override
  call(Store<T> store, action, next) async {
    store.dispatch(IsProvisionedAction(await IdidFlutter.isProvisioned));
  }
}

List<Middleware<T>> createIDidMiddleware<T>() => [
      TypedMiddleware<T, ProvisionAction>(_ProvisionMiddleware<T>()),
      TypedMiddleware<T, QueryProvisionStateAction>(
          _IsProvisionedMiddleware<T>()),
      TypedMiddleware<T, AuthorizeTransactionAction>(
          _AuthorizeTransactionMiddleware<T>())
    ];

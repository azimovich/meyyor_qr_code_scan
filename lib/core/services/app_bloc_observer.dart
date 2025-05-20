import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart'; // Logging uchun

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    l.i('${bloc.runtimeType} changed: $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    l.e('${bloc.runtimeType} error: $error', stackTrace);
  }
}

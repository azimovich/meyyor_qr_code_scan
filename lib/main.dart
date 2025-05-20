import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meyyor_qr_code_scan/presentation/bloc/save_receipt_bloc.dart';
import 'core/services/app_bloc_observer.dart';
import 'core/services/service_locator.dart';
import 'presentation/bloc/home_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  await setup();
  runApp(MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  setupLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>(),
        ),

        BlocProvider<SaveReceiptBloc>(
          create: (context) => getIt<SaveReceiptBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Orc sistema',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

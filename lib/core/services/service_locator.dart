import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meyyor_qr_code_scan/data/datasource/local/receipt_local_data_source.dart';
import 'package:meyyor_qr_code_scan/domain/usecases/get_saved_receipts.dart';
import 'package:meyyor_qr_code_scan/domain/usecases/save_receipt.dart';
import 'package:meyyor_qr_code_scan/presentation/bloc/home_bloc.dart';
import 'package:meyyor_qr_code_scan/presentation/bloc/save_receipt_bloc.dart';

import '../../data/datasource/remote/receipt_remote_data_source.dart';
import '../../data/repositories/receipt_repository_impl.dart';
import '../../domain/repositories/receipt_repository.dart';
import '../../domain/usecases/get_receipt.dart';
import 'interceptors/dio_interceptor.dart';
import 'temp_image_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Service layer (local DB helper)
  // getIt.registerLazySingleton<LocalDbHelper>(() => LocalDbHelper());

  final options = BaseOptions(
    baseUrl: "https://generativelanguage.googleapis.com",
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    contentType: "application/json",
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );
  final Dio dio = Dio(options);
  dio.interceptors.add(DioInterceptor());
  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<TempImageService>(() => TempImageService());

  // Datasource
  getIt.registerLazySingleton<ReceiptRemoteDataSource>(
    () => ReceiptRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ReceiptLocalDataSource>(
    () => ReceiptLocalDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<ReceiptRepository>(
    () =>
        ReceiptRepositoryImpl(receiptRemoteDataSource: getIt<ReceiptRemoteDataSource>(), localDataSource: getIt<ReceiptLocalDataSource>()),
  );

  // Usecase
  getIt.registerLazySingleton<GetReceiptUseCase>(
    () => GetReceiptUseCase(getIt<ReceiptRepository>()),
  );

  getIt.registerLazySingleton<SaveReceiptUseCase>(
    () => SaveReceiptUseCase(getIt<ReceiptRepository>()),
  );

  getIt.registerLazySingleton<GetSavedReceiptsUseCase>(
    () => GetSavedReceiptsUseCase(getIt<ReceiptRepository>()),
  );

  // Bloc
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getSavedReceiptsUseCase: getIt<GetSavedReceiptsUseCase>()),
  );

  getIt.registerFactory<SaveReceiptBloc>(
    () => SaveReceiptBloc(getReceiptUseCase: getIt<GetReceiptUseCase>(), saveReceiptUseCase: getIt<SaveReceiptUseCase>()),
  );


}

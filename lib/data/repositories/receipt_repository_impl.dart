import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meyyor_qr_code_scan/core/errors/failure.dart';
import 'package:meyyor_qr_code_scan/data/datasource/remote/receipt_remote_data_source.dart';
import 'package:meyyor_qr_code_scan/domain/entities/receipt_entity.dart';
import 'package:meyyor_qr_code_scan/domain/repositories/receipt_repository.dart';

import '../../core/errors/exception.dart';
import '../datasource/local/receipt_local_data_source.dart';

class ReceiptRepositoryImpl implements ReceiptRepository {
  final ReceiptRemoteDataSource receiptRemoteDataSource;
  final ReceiptLocalDataSource localDataSource;

  ReceiptRepositoryImpl({required this.receiptRemoteDataSource, required this.localDataSource});
  @override
  Future<void> saveReceipt(ReceiptEntity receipt) {
    return localDataSource.addReceipt(receipt);
  }

  @override
  Future<List<ReceiptEntity>> getSavedReceipts() {
    return localDataSource.getAllReceipts();
  }

  @override
  Future<Either<Failure, ReceiptEntity>> getReceipt(String base64Image) async {
    try {
      final model = await receiptRemoteDataSource.getReceipt(base64Image: base64Image);
      log(model.toString(), name: 'Repo');
      final entity = model.toEntity();
      return Right(entity);
    } on DioException catch (e) {
      return Left(DioExceptions.fromDioError(e));
    } catch (e) {
      return Left(UnknownFailure("Unknown error occurred: ${e.toString()}"));
    }
  }
}

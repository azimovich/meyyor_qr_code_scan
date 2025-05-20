import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/receipt_entity.dart';

abstract class ReceiptRepository {
  Future<Either<Failure, ReceiptEntity>> getReceipt(String base64Image);
  Future<void> saveReceipt(ReceiptEntity receipt);
  Future<List<ReceiptEntity>> getSavedReceipts();
}

import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/receipt_entity.dart';
import '../repositories/receipt_repository.dart';

class GetReceiptUseCase {
  final ReceiptRepository repository;

  GetReceiptUseCase(this.repository);

  Future<Either<Failure, ReceiptEntity>> call(String base64Image) {
    return repository.getReceipt(base64Image);
  }
}

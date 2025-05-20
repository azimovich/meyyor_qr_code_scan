import '../entities/receipt_entity.dart';
import '../repositories/receipt_repository.dart';

class SaveReceiptUseCase {
  final ReceiptRepository repository;

  SaveReceiptUseCase(this.repository);

  Future<void> call(ReceiptEntity receipt) {
    return repository.saveReceipt(receipt);
  }
}

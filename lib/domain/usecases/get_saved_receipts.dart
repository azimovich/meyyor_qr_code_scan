import '../entities/receipt_entity.dart';
import '../repositories/receipt_repository.dart';

class GetSavedReceiptsUseCase {
  final ReceiptRepository repository;

  GetSavedReceiptsUseCase(this.repository);

  Future<List<ReceiptEntity>> call() {
    return repository.getSavedReceipts();
  }
}
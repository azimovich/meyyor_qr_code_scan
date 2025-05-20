import '../../data/models/receipt_response_model.dart';

class ReceiptEntity {
  final String dateAndTime;
  final String storeName;
  final List<ReceiptItemEntity> items;
  final double total;
  final String paymentMethod;
  final String category;

  ReceiptEntity({
    required this.dateAndTime,
    required this.storeName,
    required this.items,
    required this.total,
    required this.paymentMethod,
    this.category = "Boshqa",
  });

  ReceiptEntity copyWith({
    String? dateAndTime,
    String? storeName,
    List<ReceiptItemEntity>? items,
    double? total,
    String? paymentMethod,
    String? category,
  }) {
    return ReceiptEntity(
      dateAndTime: dateAndTime ?? this.dateAndTime,
      storeName: storeName ?? this.storeName,
      items: items ?? this.items,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      category: category ?? this.category,
    );
  }
}

class ReceiptItemEntity {
  final String name;
  final double price;
  final double total;

  ReceiptItemEntity({
    required this.name,
    required this.price,
    required this.total,
  });

  ReceiptItemEntity copyWith({
    String? name,
    double? price,
    double? total,
  }) {
    return ReceiptItemEntity(
      name: name ?? this.name,
      price: price ?? this.price,
      total: total ?? this.total,
    );
  }
}

extension ReceiptMapper on ReceiptResponseModel {
  ReceiptEntity toEntity() {
    return ReceiptEntity(
      dateAndTime: receiptDetails.dateAndTime,
      storeName: receiptDetails.storeName,
      items: receiptDetails.itemsPurchased.map((e) {
        return ReceiptItemEntity(
          name: e.name,
          price: double.tryParse(e.price) ?? 0.0,
          total: double.tryParse(e.totalPrice) ?? 0.0,
        );
      }).toList(),
      total: double.tryParse(receiptDetails.totalPurchase) ?? 0.0,
      paymentMethod: receiptDetails.paymentMethod,
    );
  }
}

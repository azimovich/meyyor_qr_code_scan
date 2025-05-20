class ReceiptResponseModel {
  final ReceiptDetails receiptDetails;

  ReceiptResponseModel({required this.receiptDetails});

  factory ReceiptResponseModel.fromJson(Map<String, dynamic> json) {
    return ReceiptResponseModel(
      receiptDetails: ReceiptDetails.fromJson(json['receipt_information']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receipt_information': receiptDetails.toJson(),
    };
  }
}

class ReceiptDetails {
  final String dateAndTime;
  final String storeName;
  final List<ItemsPurchasedModel> itemsPurchased;
  final String totalPurchase;
  final String paymentMethod;

  ReceiptDetails({
    required this.dateAndTime,
    required this.storeName,
    required this.itemsPurchased,
    required this.totalPurchase,
    required this.paymentMethod,
  });

  factory ReceiptDetails.fromJson(Map<String, dynamic> json) {
    return ReceiptDetails(
      dateAndTime: json['date_time'] ?? '',
      storeName: json['store_name'] ?? '',
      itemsPurchased: (json['items'] as List).map((e) => ItemsPurchasedModel.fromJson(e)).toList(),
      totalPurchase: json['total_purchase'] ?? '0',
      paymentMethod: json['payment_method'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_time': dateAndTime,
      'store_name': storeName,
      'items': itemsPurchased.map((e) => e.toJson()).toList(),
      'total_purchase': totalPurchase,
      'payment_method': paymentMethod,
    };
  }
}

class ItemsPurchasedModel {
  final String name;
  final String price;
  final String totalPrice;

  ItemsPurchasedModel({
    required this.name,
    required this.price,
    required this.totalPrice,
  });

  factory ItemsPurchasedModel.fromJson(Map<String, dynamic> json) {
    return ItemsPurchasedModel(
      name: json['name'] ?? '',
      price: (json['price'] as String).replaceAll(',', '.'),
      totalPrice: (json['totalPrice'] as String).replaceAll(',', '.'),
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'totalPrice': totalPrice,
    };
  }

}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:meyyor_qr_code_scan/data/models/receipt_response_model.dart';

import '../../../domain/entities/receipt_entity.dart';

abstract class ReceiptLocalDataSource {
  Future<void> addReceipt(ReceiptEntity receipt);
  Future<List<ReceiptEntity>> getAllReceipts();
}

// class ReceiptLocalDataSourceImpl implements ReceiptLocalDataSource {
//   static const _key = 'LOCAL_RECEIPTS';

//   @override
//   Future<void> addReceipt(ReceiptEntity receipt) async {
//     final prefs = await SharedPreferences.getInstance();
//     final oldData = prefs.getStringList(_key) ?? [];

//     final newData = jsonEncode(_receiptEntityToMap(receipt));
//     await prefs.setStringList(_key, [...oldData, newData]);
//   }

//   @override
//   Future<List<ReceiptEntity>> getAllReceipts() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getStringList(_key) ?? [];

//     return data.map((e) => _mapToReceiptEntity(jsonDecode(e))).toList();
//   }

//   Map<String, dynamic> _receiptEntityToMap(ReceiptEntity entity) {
//     return {
//       'dateTime': entity.dateAndTime,
//       'storeName': entity.storeName,
//       'itemsPurchased': entity.items.map((e) => {
//         'name': e.name,
//         'price': e.price,
//         'totalPrice': e.price,
//       }).toList(),
//       'totalPurchase': entity.total,
//       'paymentMethod': entity.paymentMethod,
//     };
//   }

//   ReceiptEntity _mapToReceiptEntity(Map<String, dynamic> map) {
//     return ReceiptEntity(
//       dateAndTime: map['dateTime'],
//       storeName: map['storeName'],
//       items: (map['itemsPurchased'] as List).map((e) => ReceiptItemEntity(
//         name: e['name'],
//         price: e['price'],
//         total: e['totalPrice'],
//       )).toList(),
//       total: map['totalPurchase'],
//       paymentMethod: map['paymentMethod'],
//     );
//   }
// }

class ReceiptLocalDataSourceImpl implements ReceiptLocalDataSource {
  static const _key = 'LOCAL_RECEIPTS';

  @override
  Future<void> addReceipt(ReceiptEntity receipt) async {
    final prefs = await SharedPreferences.getInstance();
    final oldData = prefs.getStringList(_key) ?? [];

    final newData = jsonEncode(_receiptEntityToMap(receipt));
    await prefs.setStringList(_key, [...oldData, newData]);
  }

  @override
  Future<List<ReceiptEntity>> getAllReceipts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];

    return data.map((e) => _mapToReceiptEntity(jsonDecode(e))).toList();
  }

  Map<String, dynamic> _receiptEntityToMap(ReceiptEntity entity) {
    return {
      'dateTime': entity.dateAndTime,
      'storeName': entity.storeName,
      'itemsPurchased': entity.items
          .map((e) => {
                'name': e.name,
                'price': e.price,
                'totalPrice': e.total, 
              })
          .toList(),
      'totalPurchase': entity.total,
      'paymentMethod': entity.paymentMethod,
      'category' : entity.category
    };
  }

  ReceiptEntity _mapToReceiptEntity(Map<String, dynamic> map) {
    return ReceiptEntity(
      dateAndTime: map['dateTime'],
      storeName: map['storeName'],
      items: (map['itemsPurchased'] as List)
          .map((e) => ReceiptItemEntity(
                name: e['name'],
                price: (e['price'] as num).toDouble(), // ✅ xavfsiz konvertatsiya
                total: (e['totalPrice'] as num).toDouble(),
              ))
          .toList(),
      total: (map['totalPurchase'] as num).toDouble(),
      paymentMethod: map['paymentMethod'],
      category: map['category']
    );
  }
}

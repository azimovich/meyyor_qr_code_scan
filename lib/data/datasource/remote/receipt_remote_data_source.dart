import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/interceptors/dio_interceptor.dart';
import '../../models/receipt_response_model.dart';

abstract class ReceiptRemoteDataSource {
  Future<ReceiptResponseModel> getReceipt({required String base64Image});
}

class ReceiptRemoteDataSourceImpl implements ReceiptRemoteDataSource {
  // final Dio dio;

  // ReceiptRemoteDataSourceImpl({required this.dio});

  static const _apiKey = 'AIzaSyC2Gs0PRuVa6VQj6i5CK7ZW3o6rRrzVvjM';
//   final _prompt = '''
//   Extract what I said from this image using the ocr system and return it to me in json format:

// 1. Date and time the receipt was issued (Store name usually ends with MCHj)
// 2. Which store was the purchase made from
// 3. What items were purchased and how much. Only 3 fields should be used for the product. Name, price, totalPrice. Name should contain the product name with the amount purchased in () brackets. price is the product price, what was the total price
// 4. How much was the total purchase
// 5. What was the payment method

// Please provide it to me separately.
// class ReceiptResponseModel {
//   final ReceiptDetails receiptDetails;

//   ReceiptResponseModel({required this.receiptDetails});

//   factory ReceiptResponseModel.fromJson(Map<String, dynamic> json) {
//     return ReceiptResponseModel(
//       receiptDetails: ReceiptDetails.fromJson(json['receipt_information']),
//     );
//   }
// }

// class ReceiptDetails {
//   final String dateAndTime;
//   final String storeName;
//   final List<ItemsPurchasedModel> itemsPurchased;
//   final String totalPurchase;
//   final String paymentMethod;

//   ReceiptDetails({
//     required this.dateAndTime,
//     required this.storeName,
//     required this.itemsPurchased,
//     required this.totalPurchase,
//     required this.paymentMethod,
//   });

//   factory ReceiptDetails.fromJson(Map<String, dynamic> json) {
//     return ReceiptDetails(
//       dateAndTime: json['date_time'],
//       storeName: json['store_name'],
//       itemsPurchased: (json['items'] as List).map((e) => ItemsPurchasedModel.fromJson(e)).toList(),
//       totalPurchase: json['total_purchase'],
//       paymentMethod: json['payment_method'],
//     );
//   }
// }

// class ItemsPurchasedModel {
//   final String name;
//   final String price;
//   final String totalPrice;

//   ItemsPurchasedModel({
//     required this.name,
//     required this.price,
//     required this.totalPrice,
//   });

//   factory ItemsPurchasedModel.fromJson(Map<String, dynamic> json) {
//     return ItemsPurchasedModel(
//       name: json['name'],
//       price: json['price'],
//       totalPrice: json['totalPrice'],
//     );
//   }
// }
// Live according to this model.
//   ''';

  final _prompt = '''
  Extract the following details from the image of a receipt and return it as a JSON object that follows this exact structure:

{
  "receipt_information": {
    "date_time": "YYYY-MM-DD HH:mm",
    "store_name": "Name of the store (ends with MCHj)",
    "items": [
      {
        "name": "Product name (quantity in brackets)",
        "price": "Product price (as string, e.g., '12500.0')",
        "totalPrice": "Total price for that item (as string)"
      }
    ],
    "total_purchase": "Total purchase amount (as string)",
    "payment_method": "The payment method used"
  }
}

⚠️ Notes:
- All price-related fields (price, totalPrice, total_purchase) must be returned as **strings** (even if they are numbers).
- Make sure `store_name` ends with "MCHj".
- If any value is not found, leave it as an empty string "".
- Return only the data in the given JSON structure, nothing else.

Example output:
{
  "receipt_information": {
    "date_time": "2024-12-01 14:25",
    "store_name": "Yulduz MCHj",
    "items": [
      {
        "name": "Milk (2)",
        "price": "6500.0",
        "totalPrice": "13000.0"
      }
    ],
    "total_purchase": "13000.0",
    "payment_method": "Card"
  }
}

   ''';
  @override
  Future<ReceiptResponseModel> getReceipt({required String base64Image}) async {
    try {
      final dio = Dio();
      dio.interceptors.add(DioInterceptor());

      final response = await dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "contents": [
            {
              "parts": [
                {"text": _prompt},
                {
                  "inlineData": {"mimeType": "image/jpeg", "data": base64Image}
                }
              ]
            }
          ]
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        try {
          final String content = response.data['candidates'][0]['content']['parts'][0]['text'];
          log(content, name: 'Raw content');

          // Markdown belgilarini olib tashlash
          final cleanedContent = content.replaceAll('```json', '').replaceAll('```', '').trim();
          log(cleanedContent, name: 'Cleaned content');

          // JSON parse qilish
          final Map<String, dynamic> jsonData = json.decode(cleanedContent);

          // Modelga parse qilish
          return ReceiptResponseModel.fromJson(jsonData);
        } catch (e, stackTrace) {
          log('Failed to parse receipt response model', error: e, stackTrace: stackTrace, name: 'ReceiptDataSource');

          throw Exception('Parsing error: $e');
        }
      } else {
        throw DioException(
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
          error: 'API returned status code: ${response.statusCode}',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}

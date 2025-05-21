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
  static const _apiKey = 'AIzaSyC2Gs0PRuVa6VQj6i5CK7ZW3o6rRrzVvjM';
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meyyor_qr_code_scan/domain/entities/receipt_entity.dart';

import 'info_row_widget.dart';

class HomeReceiptCardWidget extends StatelessWidget {
  final ReceiptEntity receipt;
  const HomeReceiptCardWidget({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    final parsedDateTime = DateTime.tryParse(receipt.dateAndTime) ?? DateTime.now();

    return Card(
      elevation: 0,
      color: Colors.grey.shade200,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRowWidget(
              title: '📅 Chek olingan sana',
              subtitle: DateFormat('dd.MM.yyyy').format(parsedDateTime),
            ),
            InfoRowWidget(
              title: '⏰ Chek olingan vaqt',
              subtitle: DateFormat('HH:mm').format(parsedDateTime),
            ),
            InfoRowWidget(
              title: '💵 Jami hisoblangan',
              subtitle: '${receipt.total} uzs',
            ),
            InfoRowWidget(
              title: '💳 & 💰Tolov turi ',
              subtitle: receipt.paymentMethod,
            ),
            InfoRowWidget(
              title: '🔖Kategory ',
              subtitle: receipt.category,
            ),
            const SizedBox(height: 8),
            const Text(
              '🛍 Sotib olingan mahsulotlar:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            ...receipt.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          '• ${item.name}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        '${item.total.toStringAsFixed(0)} UZS',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

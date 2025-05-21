import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meyyor_qr_code_scan/core/enum/enums.dart';
import 'package:meyyor_qr_code_scan/presentation/pages/save_receipt_page.dart';

import '../bloc/save_receipt_bloc.dart';

class ImagePreviewPage extends StatelessWidget {
  final String image;
  const ImagePreviewPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.amber.shade400,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<SaveReceiptBloc, SaveReceiptState>(
        listener: (context, state) {
          if (state.status == BlocStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.status == BlocStatus.success) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SaveReceiptPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 380,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(File(image)),
                  ),
                ),
                const Spacer(),
                MaterialButton(
                  height: 50,
                  elevation: 0,
                  disabledColor: Colors.amber.shade400,
                  onPressed: state.isFetchingReceipt
                      ? null
                      : () {
                          context.read<SaveReceiptBloc>().add(SaveReceiptEvent.getReceipt(image));
                        },
                  highlightElevation: 0,
                  shape: const StadiumBorder(),
                  color: Colors.amber.shade400,
                  minWidth: MediaQuery.of(context).size.width,
                  child: state.isFetchingReceipt
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Davom etish',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

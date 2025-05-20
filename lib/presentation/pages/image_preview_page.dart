import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meyyor_qr_code_scan/core/enum/enums.dart';
import 'package:meyyor_qr_code_scan/presentation/pages/save_receipt_page.dart';

import '../../core/services/temp_image_service.dart';
import '../../core/services/service_locator.dart' as sl;
import '../bloc/save_receipt_bloc.dart';

class ImagePreviewPage extends StatefulWidget {
  const ImagePreviewPage({super.key});

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  final tempImageService = sl.getIt<TempImageService>();
  File? image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetch();
  }

  void _fetch() async {
    final file = await tempImageService.getTempImage();
    if (file != null) {
      setState(() {
        image = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.amber.shade400,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
                if (image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 380,
                      width: MediaQuery.of(context).size.width,
                      child: Image.file(image!),
                    ),
                  )
                else
                  Center(
                      child: CircularProgressIndicator(
                    color: Colors.amber.shade400,
                  )),
                const Spacer(),
                MaterialButton(
                  height: 50,
                  elevation: 0,
                  disabledColor: Colors.amber.shade400,
                  onPressed: state.isFetchingReceipt || image == null
                      ? null
                      : () {
                          context.read<SaveReceiptBloc>().add(SaveReceiptEvent.getReceipt(image!.path));
                        },
                  highlightElevation: 0,
                  shape: const StadiumBorder(),
                  color: Colors.amber.shade400,
                  minWidth: MediaQuery.of(context).size.width,
                  child: state.isFetchingReceipt
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
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

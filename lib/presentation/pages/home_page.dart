// ignore_for_file: use_build_context_synchronously

// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meyyor_qr_code_scan/presentation/blocs/home_bloc.dart';
import 'package:meyyor_qr_code_scan/presentation/pages/image_preview_page.dart';
import 'package:meyyor_qr_code_scan/presentation/widgets/info_row_widget.dart';

import '../../core/enum/enums.dart';
import '../../core/services/service_locator.dart' as sl;
import '../../core/services/temp_image_service.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tempImageService = sl.getIt<TempImageService>();

  @override
  void initState() {
    _fetch();
    super.initState();
  }

  void _fetch() {
    context.read<HomeBloc>().add(HomeEvent.loadReceipts());
  }

  void _showImagePickerBottomSheet(BuildContext bottomSheetContext, BuildContext parentContext) {
    showModalBottomSheet(
      context: bottomSheetContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Kameradan olish"),
              onTap: () async {
                Navigator.of(context).pop(); // bottomSheet yopiladi
                final image = await ImagePicker().pickImage(source: ImageSource.camera);
                if (image != null) {
                  await tempImageService.saveTempImage(image);
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(
                      builder: (_) => ImagePreviewPage(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Galereyadan tanlash"),
              onTap: () async {
                Navigator.of(context).pop(); // bottomSheet yopiladi
                final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  await tempImageService.saveTempImage(image);
                  // final tempImage = await tempImageService.getTempImage();
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(
                      builder: (_) => ImagePreviewPage(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.amber.shade400,
        title: Text(
          "Sinzning Cheklaringiz Ro'yxati",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MaterialButton(
        height: 48,
        onPressed: () => _showImagePickerBottomSheet(context, context),
        elevation: 0,
        highlightElevation: 0,
        shape: StadiumBorder(),
        color: Colors.amber.shade400,
        child: Text(
          "Yangi chek qo'yish",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _fetch(),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.status == BlocStatus.error) {
              log('${state.errorMessage}');
            }
          },
          builder: (context, state) {
            if (state.status == BlocStatus.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber.shade400,
                ),
              );
            } else if (state.status == BlocStatus.success) {
              if (state.receipts.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      'Hozirda sizda hech qanday chek royxatga olinmagan',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  final receipt = state.receipts[index];
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
                },
                separatorBuilder: (context, index) => SizedBox(height: 4),
                itemCount: state.receipts.length,
              );
            } else {
              return Center(
                child: Text('$state'),
              );
            }
          },
        ),
      ),
    );
  }
}

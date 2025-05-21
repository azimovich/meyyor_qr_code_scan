// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meyyor_qr_code_scan/presentation/pages/image_preview_page.dart';
import 'package:meyyor_qr_code_scan/presentation/widgets/bottom_sheet_button.dart';
import 'package:meyyor_qr_code_scan/presentation/widgets/home_receipt_card_widget.dart';

import '../../core/enum/enums.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            BottomSheetButton(
              title: "Kameradan tanlash",
              iconData: Icons.camera_alt,
              onPressed: () async {
                Navigator.of(context).pop();
                final image = await ImagePicker().pickImage(source: ImageSource.camera);
                if (image != null) {
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(
                      builder: (_) => ImagePreviewPage(
                        image: image.path,
                      ),
                    ),
                  );
                }
              },
            ),
            BottomSheetButton(
              title: "Galereyadan tanlash",
              iconData: Icons.photo_library,
              onPressed: () async {
                Navigator.of(context).pop();
                final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(
                      builder: (_) => ImagePreviewPage(
                        image: image.path,
                      ),
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

                  return HomeReceiptCardWidget(receipt: receipt);
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

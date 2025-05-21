import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meyyor_qr_code_scan/core/enum/enums.dart';
// import 'package:meyyor_qr_code_scan/presentation/bloc/home_bloc.dart';
import '../bloc/save_receipt_bloc.dart';
import 'home_page.dart';

class SaveReceiptPage extends StatefulWidget {
  const SaveReceiptPage({super.key});

  @override
  State<SaveReceiptPage> createState() => _SaveReceiptPageState();
}

class _SaveReceiptPageState extends State<SaveReceiptPage> {
  final _storeNameController = TextEditingController();
  final _dateController = TextEditingController();
  final _totalController = TextEditingController();

  final List<String> _categories = [
    "Taxi",
    "Transport",
    "Oziq-ovqat",
    "Ko'chada ovqatlanish",
    "Salomatlik",
    "Ko'ngil ochar",
    "Kiyim",
    "Oylik to'lov",
    "Savg'alar",
    "Kredit",
    "Boshqa"
  ];

  String _selectedCategory = "Boshqa"; // default

  @override
  void initState() {
    super.initState();
    final receipt = context.read<SaveReceiptBloc>().state.receipt;

    if (receipt != null) {
      _storeNameController.text = receipt.storeName;
      _dateController.text = receipt.dateAndTime;
      _totalController.text = receipt.total.toString();
      _selectedCategory = receipt.category;
    }
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _dateController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  void _saveReceipt() {
    final bloc = context.read<SaveReceiptBloc>();
    final currentReceipt = bloc.state.receipt;

    if (currentReceipt == null) return;

    final updatedReceipt = currentReceipt.copyWith(
      storeName: _storeNameController.text,
      dateAndTime: _dateController.text,
      total: double.tryParse(_totalController.text) ?? 0.0,
      category: _selectedCategory,
    );

    bloc.add(SaveReceiptEvent.addReceipt(updatedReceipt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Chekdan JSON ajratish", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.amber.shade400,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<SaveReceiptBloc, SaveReceiptState>(
        listener: (context, state) {
          if (state.isSavedReceipt == true) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          } else if (state.status == BlocStatus.failure && state.isSavingReceipt) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Noma’lum xatolik"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == BlocStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: _storeNameController,
                  decoration: const InputDecoration(labelText: 'Do‘kon nomi'),
                ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Sana'),
                ),
                TextField(
                  controller: _totalController,
                  decoration: const InputDecoration(labelText: 'Umumiy summa'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: _categories
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Kategoriya tanlang'),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: Colors.grey.shade100,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("🛍 Sotib olingan mahsulotlar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.receipt!.items.length,
                            itemBuilder: (context, index) {
                              final item = state.receipt!.items[index];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.name),
                                  Text('${item.price.toStringAsFixed(2)} UZS'),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<SaveReceiptBloc, SaveReceiptState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              height: 50,
              elevation: 0,
              onPressed: state.isSavingReceipt ? null : _saveReceipt,
              highlightElevation: 0,
              shape: const StadiumBorder(),
              color: Colors.amber.shade400,
              disabledColor: Colors.amber.shade400,
              minWidth: MediaQuery.of(context).size.width,
              child: state.isSavingReceipt
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Saqlash',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
          );
        },
      ),
    );
  }
}

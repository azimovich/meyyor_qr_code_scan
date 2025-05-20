import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meyyor_qr_code_scan/core/enum/enums.dart';
import 'package:meyyor_qr_code_scan/domain/entities/receipt_entity.dart';
import 'package:meyyor_qr_code_scan/domain/usecases/get_receipt.dart';
import 'package:meyyor_qr_code_scan/domain/usecases/save_receipt.dart';

part 'save_receipt_bloc.freezed.dart';

class SaveReceiptBloc extends Bloc<SaveReceiptEvent, SaveReceiptState> {
  final GetReceiptUseCase getReceiptUseCase;
  final SaveReceiptUseCase saveReceiptUseCase;

  SaveReceiptBloc({required this.getReceiptUseCase, required this.saveReceiptUseCase}) : super(SaveReceiptState()) {
    on<_GetReceipt>(_onGetReceipt);
    on<_AddReceipt>(_onAddReceipt);
  }

  Future<void> _onGetReceipt(_GetReceipt event, Emitter<SaveReceiptState> emit) async {
    emit(state.copyWith(isFetchingReceipt: true, status: BlocStatus.loading));
    try {
      final bytes = await File(event.imagePath).readAsBytes();
      final base64Image = base64Encode(bytes);

      final result = await getReceiptUseCase.call(base64Image);
      result.fold(
        (failure) {
          log('GetReceipt Failure: ${failure.message}');
          emit(state.copyWith(isFetchingReceipt: false, status: BlocStatus.failure));
        },
        (success) {
          log('GetReceipt Success: ${success.toString()}');
          emit(state.copyWith(
            isFetchingReceipt: false,
            status: BlocStatus.success,
            receipt: success,
          ));
        },
      );
    } catch (e) {
      log('Error in _onGetReceipt: $e');
      emit(state.copyWith(isFetchingReceipt: false, status: BlocStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onAddReceipt(_AddReceipt event, Emitter<SaveReceiptState> emit) async {
    emit(state.copyWith(isSavingReceipt: true, isSavedReceipt: false));

    try {
      await saveReceiptUseCase.call(event.receipt);
      emit(state.copyWith(isSavingReceipt: false, isSavedReceipt: true));
    } catch (e) {
      emit(state.copyWith(isSavingReceipt: false, isSavedReceipt: false, errorMessage: e.toString()));
    }
  }
}

@freezed
class SaveReceiptEvent with _$SaveReceiptEvent {
  const factory SaveReceiptEvent.getReceipt(String imagePath) = _GetReceipt;
  const factory SaveReceiptEvent.addReceipt(ReceiptEntity receipt) = _AddReceipt;
}

@freezed
abstract class SaveReceiptState with _$SaveReceiptState {
  const factory SaveReceiptState({
    @Default(false) bool isFetchingReceipt,
    @Default(false) bool isSavingReceipt,
    @Default(false) bool isSavedReceipt,
    @Default(BlocStatus.initial) BlocStatus status,
    String? errorMessage,
    ReceiptEntity? receipt,
  }) = _SaveReceiptState;
}

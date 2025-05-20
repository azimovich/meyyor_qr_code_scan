import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/enum/enums.dart';
import '../../domain/entities/receipt_entity.dart';
import '../../domain/usecases/get_saved_receipts.dart';

part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetSavedReceiptsUseCase getSavedReceiptsUseCase;
  HomeBloc({required this.getSavedReceiptsUseCase}) : super(HomeState()) {
    on<HomeEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: BlocStatus.loading));

        final receipts = await getSavedReceiptsUseCase.call();
        emit(state.copyWith(status: BlocStatus.success, receipts: receipts));
      } catch (e) {
        emit(state.copyWith(status: BlocStatus.failure, errorMessage: '$e'));
      }
    });
  }
}

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadReceipts() = _LoadReceipts;
}

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(BlocStatus.initial) BlocStatus status,
    String? errorMessage,
    @Default(<ReceiptEntity>[]) List<ReceiptEntity> receipts,
  }) = _HomeState;
}

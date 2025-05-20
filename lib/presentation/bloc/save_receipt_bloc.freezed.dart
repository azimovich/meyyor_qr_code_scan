// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_receipt_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SaveReceiptEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SaveReceiptEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SaveReceiptEvent()';
  }
}

/// @nodoc
class $SaveReceiptEventCopyWith<$Res> {
  $SaveReceiptEventCopyWith(
      SaveReceiptEvent _, $Res Function(SaveReceiptEvent) __);
}

/// @nodoc

class _GetReceipt implements SaveReceiptEvent {
  const _GetReceipt(this.imagePath);

  final String imagePath;

  /// Create a copy of SaveReceiptEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetReceiptCopyWith<_GetReceipt> get copyWith =>
      __$GetReceiptCopyWithImpl<_GetReceipt>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetReceipt &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imagePath);

  @override
  String toString() {
    return 'SaveReceiptEvent.getReceipt(imagePath: $imagePath)';
  }
}

/// @nodoc
abstract mixin class _$GetReceiptCopyWith<$Res>
    implements $SaveReceiptEventCopyWith<$Res> {
  factory _$GetReceiptCopyWith(
          _GetReceipt value, $Res Function(_GetReceipt) _then) =
      __$GetReceiptCopyWithImpl;
  @useResult
  $Res call({String imagePath});
}

/// @nodoc
class __$GetReceiptCopyWithImpl<$Res> implements _$GetReceiptCopyWith<$Res> {
  __$GetReceiptCopyWithImpl(this._self, this._then);

  final _GetReceipt _self;
  final $Res Function(_GetReceipt) _then;

  /// Create a copy of SaveReceiptEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? imagePath = null,
  }) {
    return _then(_GetReceipt(
      null == imagePath
          ? _self.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _AddReceipt implements SaveReceiptEvent {
  const _AddReceipt(this.receipt);

  final ReceiptEntity receipt;

  /// Create a copy of SaveReceiptEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddReceiptCopyWith<_AddReceipt> get copyWith =>
      __$AddReceiptCopyWithImpl<_AddReceipt>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddReceipt &&
            (identical(other.receipt, receipt) || other.receipt == receipt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receipt);

  @override
  String toString() {
    return 'SaveReceiptEvent.addReceipt(receipt: $receipt)';
  }
}

/// @nodoc
abstract mixin class _$AddReceiptCopyWith<$Res>
    implements $SaveReceiptEventCopyWith<$Res> {
  factory _$AddReceiptCopyWith(
          _AddReceipt value, $Res Function(_AddReceipt) _then) =
      __$AddReceiptCopyWithImpl;
  @useResult
  $Res call({ReceiptEntity receipt});
}

/// @nodoc
class __$AddReceiptCopyWithImpl<$Res> implements _$AddReceiptCopyWith<$Res> {
  __$AddReceiptCopyWithImpl(this._self, this._then);

  final _AddReceipt _self;
  final $Res Function(_AddReceipt) _then;

  /// Create a copy of SaveReceiptEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? receipt = null,
  }) {
    return _then(_AddReceipt(
      null == receipt
          ? _self.receipt
          : receipt // ignore: cast_nullable_to_non_nullable
              as ReceiptEntity,
    ));
  }
}

/// @nodoc
mixin _$SaveReceiptState {
  bool get isFetchingReceipt;
  bool get isSavingReceipt;
  bool get isSavedReceipt;
  BlocStatus get status;
  String? get errorMessage;
  ReceiptEntity? get receipt;

  /// Create a copy of SaveReceiptState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SaveReceiptStateCopyWith<SaveReceiptState> get copyWith =>
      _$SaveReceiptStateCopyWithImpl<SaveReceiptState>(
          this as SaveReceiptState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SaveReceiptState &&
            (identical(other.isFetchingReceipt, isFetchingReceipt) ||
                other.isFetchingReceipt == isFetchingReceipt) &&
            (identical(other.isSavingReceipt, isSavingReceipt) ||
                other.isSavingReceipt == isSavingReceipt) &&
            (identical(other.isSavedReceipt, isSavedReceipt) ||
                other.isSavedReceipt == isSavedReceipt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.receipt, receipt) || other.receipt == receipt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFetchingReceipt,
      isSavingReceipt, isSavedReceipt, status, errorMessage, receipt);

  @override
  String toString() {
    return 'SaveReceiptState(isFetchingReceipt: $isFetchingReceipt, isSavingReceipt: $isSavingReceipt, isSavedReceipt: $isSavedReceipt, status: $status, errorMessage: $errorMessage, receipt: $receipt)';
  }
}

/// @nodoc
abstract mixin class $SaveReceiptStateCopyWith<$Res> {
  factory $SaveReceiptStateCopyWith(
          SaveReceiptState value, $Res Function(SaveReceiptState) _then) =
      _$SaveReceiptStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isFetchingReceipt,
      bool isSavingReceipt,
      bool isSavedReceipt,
      BlocStatus status,
      String? errorMessage,
      ReceiptEntity? receipt});
}

/// @nodoc
class _$SaveReceiptStateCopyWithImpl<$Res>
    implements $SaveReceiptStateCopyWith<$Res> {
  _$SaveReceiptStateCopyWithImpl(this._self, this._then);

  final SaveReceiptState _self;
  final $Res Function(SaveReceiptState) _then;

  /// Create a copy of SaveReceiptState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFetchingReceipt = null,
    Object? isSavingReceipt = null,
    Object? isSavedReceipt = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? receipt = freezed,
  }) {
    return _then(_self.copyWith(
      isFetchingReceipt: null == isFetchingReceipt
          ? _self.isFetchingReceipt
          : isFetchingReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      isSavingReceipt: null == isSavingReceipt
          ? _self.isSavingReceipt
          : isSavingReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      isSavedReceipt: null == isSavedReceipt
          ? _self.isSavedReceipt
          : isSavedReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      receipt: freezed == receipt
          ? _self.receipt
          : receipt // ignore: cast_nullable_to_non_nullable
              as ReceiptEntity?,
    ));
  }
}

/// @nodoc

class _SaveReceiptState implements SaveReceiptState {
  const _SaveReceiptState(
      {this.isFetchingReceipt = false,
      this.isSavingReceipt = false,
      this.isSavedReceipt = false,
      this.status = BlocStatus.initial,
      this.errorMessage,
      this.receipt});

  @override
  @JsonKey()
  final bool isFetchingReceipt;
  @override
  @JsonKey()
  final bool isSavingReceipt;
  @override
  @JsonKey()
  final bool isSavedReceipt;
  @override
  @JsonKey()
  final BlocStatus status;
  @override
  final String? errorMessage;
  @override
  final ReceiptEntity? receipt;

  /// Create a copy of SaveReceiptState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SaveReceiptStateCopyWith<_SaveReceiptState> get copyWith =>
      __$SaveReceiptStateCopyWithImpl<_SaveReceiptState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SaveReceiptState &&
            (identical(other.isFetchingReceipt, isFetchingReceipt) ||
                other.isFetchingReceipt == isFetchingReceipt) &&
            (identical(other.isSavingReceipt, isSavingReceipt) ||
                other.isSavingReceipt == isSavingReceipt) &&
            (identical(other.isSavedReceipt, isSavedReceipt) ||
                other.isSavedReceipt == isSavedReceipt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.receipt, receipt) || other.receipt == receipt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFetchingReceipt,
      isSavingReceipt, isSavedReceipt, status, errorMessage, receipt);

  @override
  String toString() {
    return 'SaveReceiptState(isFetchingReceipt: $isFetchingReceipt, isSavingReceipt: $isSavingReceipt, isSavedReceipt: $isSavedReceipt, status: $status, errorMessage: $errorMessage, receipt: $receipt)';
  }
}

/// @nodoc
abstract mixin class _$SaveReceiptStateCopyWith<$Res>
    implements $SaveReceiptStateCopyWith<$Res> {
  factory _$SaveReceiptStateCopyWith(
          _SaveReceiptState value, $Res Function(_SaveReceiptState) _then) =
      __$SaveReceiptStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isFetchingReceipt,
      bool isSavingReceipt,
      bool isSavedReceipt,
      BlocStatus status,
      String? errorMessage,
      ReceiptEntity? receipt});
}

/// @nodoc
class __$SaveReceiptStateCopyWithImpl<$Res>
    implements _$SaveReceiptStateCopyWith<$Res> {
  __$SaveReceiptStateCopyWithImpl(this._self, this._then);

  final _SaveReceiptState _self;
  final $Res Function(_SaveReceiptState) _then;

  /// Create a copy of SaveReceiptState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isFetchingReceipt = null,
    Object? isSavingReceipt = null,
    Object? isSavedReceipt = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? receipt = freezed,
  }) {
    return _then(_SaveReceiptState(
      isFetchingReceipt: null == isFetchingReceipt
          ? _self.isFetchingReceipt
          : isFetchingReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      isSavingReceipt: null == isSavingReceipt
          ? _self.isSavingReceipt
          : isSavingReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      isSavedReceipt: null == isSavedReceipt
          ? _self.isSavedReceipt
          : isSavedReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      receipt: freezed == receipt
          ? _self.receipt
          : receipt // ignore: cast_nullable_to_non_nullable
              as ReceiptEntity?,
    ));
  }
}

// dart format on

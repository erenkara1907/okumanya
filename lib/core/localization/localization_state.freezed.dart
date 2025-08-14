// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localization_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocalizationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Locale currentLocale) loaded,
    required TResult Function(Locale newLocale) changing,
    required TResult Function(String message, Locale currentLocale) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Locale currentLocale)? loaded,
    TResult? Function(Locale newLocale)? changing,
    TResult? Function(String message, Locale currentLocale)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Locale currentLocale)? loaded,
    TResult Function(Locale newLocale)? changing,
    TResult Function(String message, Locale currentLocale)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Changing value) changing,
    required TResult Function(LocalizationError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Changing value)? changing,
    TResult? Function(LocalizationError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loaded value)? loaded,
    TResult Function(Changing value)? changing,
    TResult Function(LocalizationError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationStateCopyWith<$Res> {
  factory $LocalizationStateCopyWith(
          LocalizationState value, $Res Function(LocalizationState) then) =
      _$LocalizationStateCopyWithImpl<$Res, LocalizationState>;
}

/// @nodoc
class _$LocalizationStateCopyWithImpl<$Res, $Val extends LocalizationState>
    implements $LocalizationStateCopyWith<$Res> {
  _$LocalizationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$LocalizationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'LocalizationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Locale currentLocale) loaded,
    required TResult Function(Locale newLocale) changing,
    required TResult Function(String message, Locale currentLocale) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Locale currentLocale)? loaded,
    TResult? Function(Locale newLocale)? changing,
    TResult? Function(String message, Locale currentLocale)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Locale currentLocale)? loaded,
    TResult Function(Locale newLocale)? changing,
    TResult Function(String message, Locale currentLocale)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Changing value) changing,
    required TResult Function(LocalizationError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Changing value)? changing,
    TResult? Function(LocalizationError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loaded value)? loaded,
    TResult Function(Changing value)? changing,
    TResult Function(LocalizationError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements LocalizationState {
  const factory Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Locale currentLocale});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$LocalizationStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentLocale = null,
  }) {
    return _then(_$LoadedImpl(
      currentLocale: null == currentLocale
          ? _value.currentLocale
          : currentLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements Loaded {
  const _$LoadedImpl({required this.currentLocale});

  @override
  final Locale currentLocale;

  @override
  String toString() {
    return 'LocalizationState.loaded(currentLocale: $currentLocale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.currentLocale, currentLocale) ||
                other.currentLocale == currentLocale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentLocale);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Locale currentLocale) loaded,
    required TResult Function(Locale newLocale) changing,
    required TResult Function(String message, Locale currentLocale) error,
  }) {
    return loaded(currentLocale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Locale currentLocale)? loaded,
    TResult? Function(Locale newLocale)? changing,
    TResult? Function(String message, Locale currentLocale)? error,
  }) {
    return loaded?.call(currentLocale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Locale currentLocale)? loaded,
    TResult Function(Locale newLocale)? changing,
    TResult Function(String message, Locale currentLocale)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(currentLocale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Changing value) changing,
    required TResult Function(LocalizationError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Changing value)? changing,
    TResult? Function(LocalizationError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loaded value)? loaded,
    TResult Function(Changing value)? changing,
    TResult Function(LocalizationError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements LocalizationState {
  const factory Loaded({required final Locale currentLocale}) = _$LoadedImpl;

  Locale get currentLocale;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangingImplCopyWith<$Res> {
  factory _$$ChangingImplCopyWith(
          _$ChangingImpl value, $Res Function(_$ChangingImpl) then) =
      __$$ChangingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Locale newLocale});
}

/// @nodoc
class __$$ChangingImplCopyWithImpl<$Res>
    extends _$LocalizationStateCopyWithImpl<$Res, _$ChangingImpl>
    implements _$$ChangingImplCopyWith<$Res> {
  __$$ChangingImplCopyWithImpl(
      _$ChangingImpl _value, $Res Function(_$ChangingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newLocale = null,
  }) {
    return _then(_$ChangingImpl(
      newLocale: null == newLocale
          ? _value.newLocale
          : newLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$ChangingImpl implements Changing {
  const _$ChangingImpl({required this.newLocale});

  @override
  final Locale newLocale;

  @override
  String toString() {
    return 'LocalizationState.changing(newLocale: $newLocale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangingImpl &&
            (identical(other.newLocale, newLocale) ||
                other.newLocale == newLocale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newLocale);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangingImplCopyWith<_$ChangingImpl> get copyWith =>
      __$$ChangingImplCopyWithImpl<_$ChangingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Locale currentLocale) loaded,
    required TResult Function(Locale newLocale) changing,
    required TResult Function(String message, Locale currentLocale) error,
  }) {
    return changing(newLocale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Locale currentLocale)? loaded,
    TResult? Function(Locale newLocale)? changing,
    TResult? Function(String message, Locale currentLocale)? error,
  }) {
    return changing?.call(newLocale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Locale currentLocale)? loaded,
    TResult Function(Locale newLocale)? changing,
    TResult Function(String message, Locale currentLocale)? error,
    required TResult orElse(),
  }) {
    if (changing != null) {
      return changing(newLocale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Changing value) changing,
    required TResult Function(LocalizationError value) error,
  }) {
    return changing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Changing value)? changing,
    TResult? Function(LocalizationError value)? error,
  }) {
    return changing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loaded value)? loaded,
    TResult Function(Changing value)? changing,
    TResult Function(LocalizationError value)? error,
    required TResult orElse(),
  }) {
    if (changing != null) {
      return changing(this);
    }
    return orElse();
  }
}

abstract class Changing implements LocalizationState {
  const factory Changing({required final Locale newLocale}) = _$ChangingImpl;

  Locale get newLocale;
  @JsonKey(ignore: true)
  _$$ChangingImplCopyWith<_$ChangingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocalizationErrorImplCopyWith<$Res> {
  factory _$$LocalizationErrorImplCopyWith(_$LocalizationErrorImpl value,
          $Res Function(_$LocalizationErrorImpl) then) =
      __$$LocalizationErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, Locale currentLocale});
}

/// @nodoc
class __$$LocalizationErrorImplCopyWithImpl<$Res>
    extends _$LocalizationStateCopyWithImpl<$Res, _$LocalizationErrorImpl>
    implements _$$LocalizationErrorImplCopyWith<$Res> {
  __$$LocalizationErrorImplCopyWithImpl(_$LocalizationErrorImpl _value,
      $Res Function(_$LocalizationErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? currentLocale = null,
  }) {
    return _then(_$LocalizationErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      currentLocale: null == currentLocale
          ? _value.currentLocale
          : currentLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$LocalizationErrorImpl implements LocalizationError {
  const _$LocalizationErrorImpl(
      {required this.message, required this.currentLocale});

  @override
  final String message;
  @override
  final Locale currentLocale;

  @override
  String toString() {
    return 'LocalizationState.error(message: $message, currentLocale: $currentLocale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalizationErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.currentLocale, currentLocale) ||
                other.currentLocale == currentLocale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, currentLocale);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalizationErrorImplCopyWith<_$LocalizationErrorImpl> get copyWith =>
      __$$LocalizationErrorImplCopyWithImpl<_$LocalizationErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Locale currentLocale) loaded,
    required TResult Function(Locale newLocale) changing,
    required TResult Function(String message, Locale currentLocale) error,
  }) {
    return error(message, currentLocale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Locale currentLocale)? loaded,
    TResult? Function(Locale newLocale)? changing,
    TResult? Function(String message, Locale currentLocale)? error,
  }) {
    return error?.call(message, currentLocale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Locale currentLocale)? loaded,
    TResult Function(Locale newLocale)? changing,
    TResult Function(String message, Locale currentLocale)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, currentLocale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loaded value) loaded,
    required TResult Function(Changing value) changing,
    required TResult Function(LocalizationError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(Changing value)? changing,
    TResult? Function(LocalizationError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loaded value)? loaded,
    TResult Function(Changing value)? changing,
    TResult Function(LocalizationError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class LocalizationError implements LocalizationState {
  const factory LocalizationError(
      {required final String message,
      required final Locale currentLocale}) = _$LocalizationErrorImpl;

  String get message;
  Locale get currentLocale;
  @JsonKey(ignore: true)
  _$$LocalizationErrorImplCopyWith<_$LocalizationErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

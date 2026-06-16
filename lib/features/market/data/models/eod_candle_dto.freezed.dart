// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eod_candle_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EodCandleDto {

 DateTime get date; double get open; double get high; double get low; double get close;
/// Create a copy of EodCandleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EodCandleDtoCopyWith<EodCandleDto> get copyWith => _$EodCandleDtoCopyWithImpl<EodCandleDto>(this as EodCandleDto, _$identity);

  /// Serializes this EodCandleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EodCandleDto&&(identical(other.date, date) || other.date == date)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,open,high,low,close);

@override
String toString() {
  return 'EodCandleDto(date: $date, open: $open, high: $high, low: $low, close: $close)';
}


}

/// @nodoc
abstract mixin class $EodCandleDtoCopyWith<$Res>  {
  factory $EodCandleDtoCopyWith(EodCandleDto value, $Res Function(EodCandleDto) _then) = _$EodCandleDtoCopyWithImpl;
@useResult
$Res call({
 DateTime date, double open, double high, double low, double close
});




}
/// @nodoc
class _$EodCandleDtoCopyWithImpl<$Res>
    implements $EodCandleDtoCopyWith<$Res> {
  _$EodCandleDtoCopyWithImpl(this._self, this._then);

  final EodCandleDto _self;
  final $Res Function(EodCandleDto) _then;

/// Create a copy of EodCandleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EodCandleDto].
extension EodCandleDtoPatterns on EodCandleDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EodCandleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EodCandleDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EodCandleDto value)  $default,){
final _that = this;
switch (_that) {
case _EodCandleDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EodCandleDto value)?  $default,){
final _that = this;
switch (_that) {
case _EodCandleDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double open,  double high,  double low,  double close)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EodCandleDto() when $default != null:
return $default(_that.date,_that.open,_that.high,_that.low,_that.close);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double open,  double high,  double low,  double close)  $default,) {final _that = this;
switch (_that) {
case _EodCandleDto():
return $default(_that.date,_that.open,_that.high,_that.low,_that.close);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double open,  double high,  double low,  double close)?  $default,) {final _that = this;
switch (_that) {
case _EodCandleDto() when $default != null:
return $default(_that.date,_that.open,_that.high,_that.low,_that.close);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EodCandleDto extends EodCandleDto {
  const _EodCandleDto({required this.date, required this.open, required this.high, required this.low, required this.close}): super._();
  factory _EodCandleDto.fromJson(Map<String, dynamic> json) => _$EodCandleDtoFromJson(json);

@override final  DateTime date;
@override final  double open;
@override final  double high;
@override final  double low;
@override final  double close;

/// Create a copy of EodCandleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EodCandleDtoCopyWith<_EodCandleDto> get copyWith => __$EodCandleDtoCopyWithImpl<_EodCandleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EodCandleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EodCandleDto&&(identical(other.date, date) || other.date == date)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,open,high,low,close);

@override
String toString() {
  return 'EodCandleDto(date: $date, open: $open, high: $high, low: $low, close: $close)';
}


}

/// @nodoc
abstract mixin class _$EodCandleDtoCopyWith<$Res> implements $EodCandleDtoCopyWith<$Res> {
  factory _$EodCandleDtoCopyWith(_EodCandleDto value, $Res Function(_EodCandleDto) _then) = __$EodCandleDtoCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double open, double high, double low, double close
});




}
/// @nodoc
class __$EodCandleDtoCopyWithImpl<$Res>
    implements _$EodCandleDtoCopyWith<$Res> {
  __$EodCandleDtoCopyWithImpl(this._self, this._then);

  final _EodCandleDto _self;
  final $Res Function(_EodCandleDto) _then;

/// Create a copy of EodCandleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,}) {
  return _then(_EodCandleDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

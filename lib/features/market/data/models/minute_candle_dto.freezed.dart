// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'minute_candle_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MinuteCandleDto {

 int get index; double get open; double get high; double get low; double get close;
/// Create a copy of MinuteCandleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MinuteCandleDtoCopyWith<MinuteCandleDto> get copyWith => _$MinuteCandleDtoCopyWithImpl<MinuteCandleDto>(this as MinuteCandleDto, _$identity);

  /// Serializes this MinuteCandleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MinuteCandleDto&&(identical(other.index, index) || other.index == index)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,open,high,low,close);

@override
String toString() {
  return 'MinuteCandleDto(index: $index, open: $open, high: $high, low: $low, close: $close)';
}


}

/// @nodoc
abstract mixin class $MinuteCandleDtoCopyWith<$Res>  {
  factory $MinuteCandleDtoCopyWith(MinuteCandleDto value, $Res Function(MinuteCandleDto) _then) = _$MinuteCandleDtoCopyWithImpl;
@useResult
$Res call({
 int index, double open, double high, double low, double close
});




}
/// @nodoc
class _$MinuteCandleDtoCopyWithImpl<$Res>
    implements $MinuteCandleDtoCopyWith<$Res> {
  _$MinuteCandleDtoCopyWithImpl(this._self, this._then);

  final MinuteCandleDto _self;
  final $Res Function(MinuteCandleDto) _then;

/// Create a copy of MinuteCandleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MinuteCandleDto].
extension MinuteCandleDtoPatterns on MinuteCandleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MinuteCandleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MinuteCandleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MinuteCandleDto value)  $default,){
final _that = this;
switch (_that) {
case _MinuteCandleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MinuteCandleDto value)?  $default,){
final _that = this;
switch (_that) {
case _MinuteCandleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  double open,  double high,  double low,  double close)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MinuteCandleDto() when $default != null:
return $default(_that.index,_that.open,_that.high,_that.low,_that.close);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  double open,  double high,  double low,  double close)  $default,) {final _that = this;
switch (_that) {
case _MinuteCandleDto():
return $default(_that.index,_that.open,_that.high,_that.low,_that.close);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  double open,  double high,  double low,  double close)?  $default,) {final _that = this;
switch (_that) {
case _MinuteCandleDto() when $default != null:
return $default(_that.index,_that.open,_that.high,_that.low,_that.close);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MinuteCandleDto extends MinuteCandleDto {
  const _MinuteCandleDto({required this.index, required this.open, required this.high, required this.low, required this.close}): super._();
  factory _MinuteCandleDto.fromJson(Map<String, dynamic> json) => _$MinuteCandleDtoFromJson(json);

@override final  int index;
@override final  double open;
@override final  double high;
@override final  double low;
@override final  double close;

/// Create a copy of MinuteCandleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MinuteCandleDtoCopyWith<_MinuteCandleDto> get copyWith => __$MinuteCandleDtoCopyWithImpl<_MinuteCandleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MinuteCandleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MinuteCandleDto&&(identical(other.index, index) || other.index == index)&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,open,high,low,close);

@override
String toString() {
  return 'MinuteCandleDto(index: $index, open: $open, high: $high, low: $low, close: $close)';
}


}

/// @nodoc
abstract mixin class _$MinuteCandleDtoCopyWith<$Res> implements $MinuteCandleDtoCopyWith<$Res> {
  factory _$MinuteCandleDtoCopyWith(_MinuteCandleDto value, $Res Function(_MinuteCandleDto) _then) = __$MinuteCandleDtoCopyWithImpl;
@override @useResult
$Res call({
 int index, double open, double high, double low, double close
});




}
/// @nodoc
class __$MinuteCandleDtoCopyWithImpl<$Res>
    implements _$MinuteCandleDtoCopyWith<$Res> {
  __$MinuteCandleDtoCopyWithImpl(this._self, this._then);

  final _MinuteCandleDto _self;
  final $Res Function(_MinuteCandleDto) _then;

/// Create a copy of MinuteCandleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? open = null,Object? high = null,Object? low = null,Object? close = null,}) {
  return _then(_MinuteCandleDto(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

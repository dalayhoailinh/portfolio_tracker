// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alpaca_bar_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlpacaBarDto {

@JsonKey(name: 'o') double get open;@JsonKey(name: 'h') double get high;@JsonKey(name: 'l') double get low;@JsonKey(name: 'c') double get close;
/// Create a copy of AlpacaBarDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlpacaBarDtoCopyWith<AlpacaBarDto> get copyWith => _$AlpacaBarDtoCopyWithImpl<AlpacaBarDto>(this as AlpacaBarDto, _$identity);

  /// Serializes this AlpacaBarDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlpacaBarDto&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,open,high,low,close);

@override
String toString() {
  return 'AlpacaBarDto(open: $open, high: $high, low: $low, close: $close)';
}


}

/// @nodoc
abstract mixin class $AlpacaBarDtoCopyWith<$Res>  {
  factory $AlpacaBarDtoCopyWith(AlpacaBarDto value, $Res Function(AlpacaBarDto) _then) = _$AlpacaBarDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'o') double open,@JsonKey(name: 'h') double high,@JsonKey(name: 'l') double low,@JsonKey(name: 'c') double close
});




}
/// @nodoc
class _$AlpacaBarDtoCopyWithImpl<$Res>
    implements $AlpacaBarDtoCopyWith<$Res> {
  _$AlpacaBarDtoCopyWithImpl(this._self, this._then);

  final AlpacaBarDto _self;
  final $Res Function(AlpacaBarDto) _then;

/// Create a copy of AlpacaBarDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? open = null,Object? high = null,Object? low = null,Object? close = null,}) {
  return _then(_self.copyWith(
open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AlpacaBarDto].
extension AlpacaBarDtoPatterns on AlpacaBarDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlpacaBarDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlpacaBarDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlpacaBarDto value)  $default,){
final _that = this;
switch (_that) {
case _AlpacaBarDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlpacaBarDto value)?  $default,){
final _that = this;
switch (_that) {
case _AlpacaBarDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'o')  double open, @JsonKey(name: 'h')  double high, @JsonKey(name: 'l')  double low, @JsonKey(name: 'c')  double close)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlpacaBarDto() when $default != null:
return $default(_that.open,_that.high,_that.low,_that.close);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'o')  double open, @JsonKey(name: 'h')  double high, @JsonKey(name: 'l')  double low, @JsonKey(name: 'c')  double close)  $default,) {final _that = this;
switch (_that) {
case _AlpacaBarDto():
return $default(_that.open,_that.high,_that.low,_that.close);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'o')  double open, @JsonKey(name: 'h')  double high, @JsonKey(name: 'l')  double low, @JsonKey(name: 'c')  double close)?  $default,) {final _that = this;
switch (_that) {
case _AlpacaBarDto() when $default != null:
return $default(_that.open,_that.high,_that.low,_that.close);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlpacaBarDto extends AlpacaBarDto {
  const _AlpacaBarDto({@JsonKey(name: 'o') required this.open, @JsonKey(name: 'h') required this.high, @JsonKey(name: 'l') required this.low, @JsonKey(name: 'c') required this.close}): super._();
  factory _AlpacaBarDto.fromJson(Map<String, dynamic> json) => _$AlpacaBarDtoFromJson(json);

@override@JsonKey(name: 'o') final  double open;
@override@JsonKey(name: 'h') final  double high;
@override@JsonKey(name: 'l') final  double low;
@override@JsonKey(name: 'c') final  double close;

/// Create a copy of AlpacaBarDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlpacaBarDtoCopyWith<_AlpacaBarDto> get copyWith => __$AlpacaBarDtoCopyWithImpl<_AlpacaBarDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlpacaBarDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlpacaBarDto&&(identical(other.open, open) || other.open == open)&&(identical(other.high, high) || other.high == high)&&(identical(other.low, low) || other.low == low)&&(identical(other.close, close) || other.close == close));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,open,high,low,close);

@override
String toString() {
  return 'AlpacaBarDto(open: $open, high: $high, low: $low, close: $close)';
}


}

/// @nodoc
abstract mixin class _$AlpacaBarDtoCopyWith<$Res> implements $AlpacaBarDtoCopyWith<$Res> {
  factory _$AlpacaBarDtoCopyWith(_AlpacaBarDto value, $Res Function(_AlpacaBarDto) _then) = __$AlpacaBarDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'o') double open,@JsonKey(name: 'h') double high,@JsonKey(name: 'l') double low,@JsonKey(name: 'c') double close
});




}
/// @nodoc
class __$AlpacaBarDtoCopyWithImpl<$Res>
    implements _$AlpacaBarDtoCopyWith<$Res> {
  __$AlpacaBarDtoCopyWithImpl(this._self, this._then);

  final _AlpacaBarDto _self;
  final $Res Function(_AlpacaBarDto) _then;

/// Create a copy of AlpacaBarDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? open = null,Object? high = null,Object? low = null,Object? close = null,}) {
  return _then(_AlpacaBarDto(
open: null == open ? _self.open : open // ignore: cast_nullable_to_non_nullable
as double,high: null == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double,low: null == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

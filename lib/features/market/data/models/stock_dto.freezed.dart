// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockDto {

 String get symbol; String get name; double get price; double get seedPrice; double get changePercent;
/// Create a copy of StockDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockDtoCopyWith<StockDto> get copyWith => _$StockDtoCopyWithImpl<StockDto>(this as StockDto, _$identity);

  /// Serializes this StockDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.seedPrice, seedPrice) || other.seedPrice == seedPrice)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,name,price,seedPrice,changePercent);

@override
String toString() {
  return 'StockDto(symbol: $symbol, name: $name, price: $price, seedPrice: $seedPrice, changePercent: $changePercent)';
}


}

/// @nodoc
abstract mixin class $StockDtoCopyWith<$Res>  {
  factory $StockDtoCopyWith(StockDto value, $Res Function(StockDto) _then) = _$StockDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String name, double price, double seedPrice, double changePercent
});




}
/// @nodoc
class _$StockDtoCopyWithImpl<$Res>
    implements $StockDtoCopyWith<$Res> {
  _$StockDtoCopyWithImpl(this._self, this._then);

  final StockDto _self;
  final $Res Function(StockDto) _then;

/// Create a copy of StockDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? name = null,Object? price = null,Object? seedPrice = null,Object? changePercent = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,seedPrice: null == seedPrice ? _self.seedPrice : seedPrice // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [StockDto].
extension StockDtoPatterns on StockDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockDto value)  $default,){
final _that = this;
switch (_that) {
case _StockDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String name,  double price,  double seedPrice,  double changePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockDto() when $default != null:
return $default(_that.symbol,_that.name,_that.price,_that.seedPrice,_that.changePercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String name,  double price,  double seedPrice,  double changePercent)  $default,) {final _that = this;
switch (_that) {
case _StockDto():
return $default(_that.symbol,_that.name,_that.price,_that.seedPrice,_that.changePercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String name,  double price,  double seedPrice,  double changePercent)?  $default,) {final _that = this;
switch (_that) {
case _StockDto() when $default != null:
return $default(_that.symbol,_that.name,_that.price,_that.seedPrice,_that.changePercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockDto extends StockDto {
  const _StockDto({required this.symbol, required this.name, required this.price, required this.seedPrice, this.changePercent = 0.0}): super._();
  factory _StockDto.fromJson(Map<String, dynamic> json) => _$StockDtoFromJson(json);

@override final  String symbol;
@override final  String name;
@override final  double price;
@override final  double seedPrice;
@override@JsonKey() final  double changePercent;

/// Create a copy of StockDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockDtoCopyWith<_StockDto> get copyWith => __$StockDtoCopyWithImpl<_StockDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.seedPrice, seedPrice) || other.seedPrice == seedPrice)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,name,price,seedPrice,changePercent);

@override
String toString() {
  return 'StockDto(symbol: $symbol, name: $name, price: $price, seedPrice: $seedPrice, changePercent: $changePercent)';
}


}

/// @nodoc
abstract mixin class _$StockDtoCopyWith<$Res> implements $StockDtoCopyWith<$Res> {
  factory _$StockDtoCopyWith(_StockDto value, $Res Function(_StockDto) _then) = __$StockDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String name, double price, double seedPrice, double changePercent
});




}
/// @nodoc
class __$StockDtoCopyWithImpl<$Res>
    implements _$StockDtoCopyWith<$Res> {
  __$StockDtoCopyWithImpl(this._self, this._then);

  final _StockDto _self;
  final $Res Function(_StockDto) _then;

/// Create a copy of StockDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? name = null,Object? price = null,Object? seedPrice = null,Object? changePercent = null,}) {
  return _then(_StockDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,seedPrice: null == seedPrice ? _self.seedPrice : seedPrice // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

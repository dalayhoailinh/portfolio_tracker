// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_tick.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LiveTick {

 String get symbol; double get price;
/// Create a copy of LiveTick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveTickCopyWith<LiveTick> get copyWith => _$LiveTickCopyWithImpl<LiveTick>(this as LiveTick, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveTick&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.price, price) || other.price == price));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,price);

@override
String toString() {
  return 'LiveTick(symbol: $symbol, price: $price)';
}


}

/// @nodoc
abstract mixin class $LiveTickCopyWith<$Res>  {
  factory $LiveTickCopyWith(LiveTick value, $Res Function(LiveTick) _then) = _$LiveTickCopyWithImpl;
@useResult
$Res call({
 String symbol, double price
});




}
/// @nodoc
class _$LiveTickCopyWithImpl<$Res>
    implements $LiveTickCopyWith<$Res> {
  _$LiveTickCopyWithImpl(this._self, this._then);

  final LiveTick _self;
  final $Res Function(LiveTick) _then;

/// Create a copy of LiveTick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? price = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveTick].
extension LiveTickPatterns on LiveTick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveTick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveTick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveTick value)  $default,){
final _that = this;
switch (_that) {
case _LiveTick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveTick value)?  $default,){
final _that = this;
switch (_that) {
case _LiveTick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  double price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveTick() when $default != null:
return $default(_that.symbol,_that.price);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  double price)  $default,) {final _that = this;
switch (_that) {
case _LiveTick():
return $default(_that.symbol,_that.price);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  double price)?  $default,) {final _that = this;
switch (_that) {
case _LiveTick() when $default != null:
return $default(_that.symbol,_that.price);case _:
  return null;

}
}

}

/// @nodoc


class _LiveTick implements LiveTick {
  const _LiveTick({required this.symbol, required this.price});
  

@override final  String symbol;
@override final  double price;

/// Create a copy of LiveTick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveTickCopyWith<_LiveTick> get copyWith => __$LiveTickCopyWithImpl<_LiveTick>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveTick&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.price, price) || other.price == price));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,price);

@override
String toString() {
  return 'LiveTick(symbol: $symbol, price: $price)';
}


}

/// @nodoc
abstract mixin class _$LiveTickCopyWith<$Res> implements $LiveTickCopyWith<$Res> {
  factory _$LiveTickCopyWith(_LiveTick value, $Res Function(_LiveTick) _then) = __$LiveTickCopyWithImpl;
@override @useResult
$Res call({
 String symbol, double price
});




}
/// @nodoc
class __$LiveTickCopyWithImpl<$Res>
    implements _$LiveTickCopyWith<$Res> {
  __$LiveTickCopyWithImpl(this._self, this._then);

  final _LiveTick _self;
  final $Res Function(_LiveTick) _then;

/// Create a copy of LiveTick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? price = null,}) {
  return _then(_LiveTick(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

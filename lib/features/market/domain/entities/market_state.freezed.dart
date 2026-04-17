// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketState {

 List<StockModel> get stocks; Map<String, List<MinuteCandle>> get candles;
/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketStateCopyWith<MarketState> get copyWith => _$MarketStateCopyWithImpl<MarketState>(this as MarketState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketState&&const DeepCollectionEquality().equals(other.stocks, stocks)&&const DeepCollectionEquality().equals(other.candles, candles));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stocks),const DeepCollectionEquality().hash(candles));

@override
String toString() {
  return 'MarketState(stocks: $stocks, candles: $candles)';
}


}

/// @nodoc
abstract mixin class $MarketStateCopyWith<$Res>  {
  factory $MarketStateCopyWith(MarketState value, $Res Function(MarketState) _then) = _$MarketStateCopyWithImpl;
@useResult
$Res call({
 List<StockModel> stocks, Map<String, List<MinuteCandle>> candles
});




}
/// @nodoc
class _$MarketStateCopyWithImpl<$Res>
    implements $MarketStateCopyWith<$Res> {
  _$MarketStateCopyWithImpl(this._self, this._then);

  final MarketState _self;
  final $Res Function(MarketState) _then;

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stocks = null,Object? candles = null,}) {
  return _then(_self.copyWith(
stocks: null == stocks ? _self.stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<StockModel>,candles: null == candles ? _self.candles : candles // ignore: cast_nullable_to_non_nullable
as Map<String, List<MinuteCandle>>,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketState].
extension MarketStatePatterns on MarketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketState value)  $default,){
final _that = this;
switch (_that) {
case _MarketState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketState value)?  $default,){
final _that = this;
switch (_that) {
case _MarketState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StockModel> stocks,  Map<String, List<MinuteCandle>> candles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketState() when $default != null:
return $default(_that.stocks,_that.candles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StockModel> stocks,  Map<String, List<MinuteCandle>> candles)  $default,) {final _that = this;
switch (_that) {
case _MarketState():
return $default(_that.stocks,_that.candles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StockModel> stocks,  Map<String, List<MinuteCandle>> candles)?  $default,) {final _that = this;
switch (_that) {
case _MarketState() when $default != null:
return $default(_that.stocks,_that.candles);case _:
  return null;

}
}

}

/// @nodoc


class _MarketState implements MarketState {
  const _MarketState({required final  List<StockModel> stocks, required final  Map<String, List<MinuteCandle>> candles}): _stocks = stocks,_candles = candles;
  

 final  List<StockModel> _stocks;
@override List<StockModel> get stocks {
  if (_stocks is EqualUnmodifiableListView) return _stocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stocks);
}

 final  Map<String, List<MinuteCandle>> _candles;
@override Map<String, List<MinuteCandle>> get candles {
  if (_candles is EqualUnmodifiableMapView) return _candles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_candles);
}


/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketStateCopyWith<_MarketState> get copyWith => __$MarketStateCopyWithImpl<_MarketState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketState&&const DeepCollectionEquality().equals(other._stocks, _stocks)&&const DeepCollectionEquality().equals(other._candles, _candles));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stocks),const DeepCollectionEquality().hash(_candles));

@override
String toString() {
  return 'MarketState(stocks: $stocks, candles: $candles)';
}


}

/// @nodoc
abstract mixin class _$MarketStateCopyWith<$Res> implements $MarketStateCopyWith<$Res> {
  factory _$MarketStateCopyWith(_MarketState value, $Res Function(_MarketState) _then) = __$MarketStateCopyWithImpl;
@override @useResult
$Res call({
 List<StockModel> stocks, Map<String, List<MinuteCandle>> candles
});




}
/// @nodoc
class __$MarketStateCopyWithImpl<$Res>
    implements _$MarketStateCopyWith<$Res> {
  __$MarketStateCopyWithImpl(this._self, this._then);

  final _MarketState _self;
  final $Res Function(_MarketState) _then;

/// Create a copy of MarketState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stocks = null,Object? candles = null,}) {
  return _then(_MarketState(
stocks: null == stocks ? _self._stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<StockModel>,candles: null == candles ? _self._candles : candles // ignore: cast_nullable_to_non_nullable
as Map<String, List<MinuteCandle>>,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PortfolioState {

 double get cash; double get realizedPnL; double get unrealizedPnL; Map<String, Position> get positions;
/// Create a copy of PortfolioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioStateCopyWith<PortfolioState> get copyWith => _$PortfolioStateCopyWithImpl<PortfolioState>(this as PortfolioState, _$identity);

  /// Serializes this PortfolioState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioState&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.realizedPnL, realizedPnL) || other.realizedPnL == realizedPnL)&&(identical(other.unrealizedPnL, unrealizedPnL) || other.unrealizedPnL == unrealizedPnL)&&const DeepCollectionEquality().equals(other.positions, positions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cash,realizedPnL,unrealizedPnL,const DeepCollectionEquality().hash(positions));

@override
String toString() {
  return 'PortfolioState(cash: $cash, realizedPnL: $realizedPnL, unrealizedPnL: $unrealizedPnL, positions: $positions)';
}


}

/// @nodoc
abstract mixin class $PortfolioStateCopyWith<$Res>  {
  factory $PortfolioStateCopyWith(PortfolioState value, $Res Function(PortfolioState) _then) = _$PortfolioStateCopyWithImpl;
@useResult
$Res call({
 double cash, double realizedPnL, double unrealizedPnL, Map<String, Position> positions
});




}
/// @nodoc
class _$PortfolioStateCopyWithImpl<$Res>
    implements $PortfolioStateCopyWith<$Res> {
  _$PortfolioStateCopyWithImpl(this._self, this._then);

  final PortfolioState _self;
  final $Res Function(PortfolioState) _then;

/// Create a copy of PortfolioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cash = null,Object? realizedPnL = null,Object? unrealizedPnL = null,Object? positions = null,}) {
  return _then(_self.copyWith(
cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,realizedPnL: null == realizedPnL ? _self.realizedPnL : realizedPnL // ignore: cast_nullable_to_non_nullable
as double,unrealizedPnL: null == unrealizedPnL ? _self.unrealizedPnL : unrealizedPnL // ignore: cast_nullable_to_non_nullable
as double,positions: null == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as Map<String, Position>,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioState].
extension PortfolioStatePatterns on PortfolioState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioState value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioState value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double cash,  double realizedPnL,  double unrealizedPnL,  Map<String, Position> positions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioState() when $default != null:
return $default(_that.cash,_that.realizedPnL,_that.unrealizedPnL,_that.positions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double cash,  double realizedPnL,  double unrealizedPnL,  Map<String, Position> positions)  $default,) {final _that = this;
switch (_that) {
case _PortfolioState():
return $default(_that.cash,_that.realizedPnL,_that.unrealizedPnL,_that.positions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double cash,  double realizedPnL,  double unrealizedPnL,  Map<String, Position> positions)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioState() when $default != null:
return $default(_that.cash,_that.realizedPnL,_that.unrealizedPnL,_that.positions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PortfolioState extends PortfolioState {
  const _PortfolioState({required this.cash, required this.realizedPnL, required this.unrealizedPnL, final  Map<String, Position> positions = const {}}): _positions = positions,super._();
  factory _PortfolioState.fromJson(Map<String, dynamic> json) => _$PortfolioStateFromJson(json);

@override final  double cash;
@override final  double realizedPnL;
@override final  double unrealizedPnL;
 final  Map<String, Position> _positions;
@override@JsonKey() Map<String, Position> get positions {
  if (_positions is EqualUnmodifiableMapView) return _positions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_positions);
}


/// Create a copy of PortfolioState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioStateCopyWith<_PortfolioState> get copyWith => __$PortfolioStateCopyWithImpl<_PortfolioState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PortfolioStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioState&&(identical(other.cash, cash) || other.cash == cash)&&(identical(other.realizedPnL, realizedPnL) || other.realizedPnL == realizedPnL)&&(identical(other.unrealizedPnL, unrealizedPnL) || other.unrealizedPnL == unrealizedPnL)&&const DeepCollectionEquality().equals(other._positions, _positions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cash,realizedPnL,unrealizedPnL,const DeepCollectionEquality().hash(_positions));

@override
String toString() {
  return 'PortfolioState(cash: $cash, realizedPnL: $realizedPnL, unrealizedPnL: $unrealizedPnL, positions: $positions)';
}


}

/// @nodoc
abstract mixin class _$PortfolioStateCopyWith<$Res> implements $PortfolioStateCopyWith<$Res> {
  factory _$PortfolioStateCopyWith(_PortfolioState value, $Res Function(_PortfolioState) _then) = __$PortfolioStateCopyWithImpl;
@override @useResult
$Res call({
 double cash, double realizedPnL, double unrealizedPnL, Map<String, Position> positions
});




}
/// @nodoc
class __$PortfolioStateCopyWithImpl<$Res>
    implements _$PortfolioStateCopyWith<$Res> {
  __$PortfolioStateCopyWithImpl(this._self, this._then);

  final _PortfolioState _self;
  final $Res Function(_PortfolioState) _then;

/// Create a copy of PortfolioState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cash = null,Object? realizedPnL = null,Object? unrealizedPnL = null,Object? positions = null,}) {
  return _then(_PortfolioState(
cash: null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as double,realizedPnL: null == realizedPnL ? _self.realizedPnL : realizedPnL // ignore: cast_nullable_to_non_nullable
as double,unrealizedPnL: null == unrealizedPnL ? _self.unrealizedPnL : unrealizedPnL // ignore: cast_nullable_to_non_nullable
as double,positions: null == positions ? _self._positions : positions // ignore: cast_nullable_to_non_nullable
as Map<String, Position>,
  ));
}


}

// dart format on

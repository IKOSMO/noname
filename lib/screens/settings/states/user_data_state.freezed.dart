// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserDataState {

 UserDataModel get user;
/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataStateCopyWith<UserDataState> get copyWith => _$UserDataStateCopyWithImpl<UserDataState>(this as UserDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataState&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'UserDataState(user: $user)';
}


}

/// @nodoc
abstract mixin class $UserDataStateCopyWith<$Res>  {
  factory $UserDataStateCopyWith(UserDataState value, $Res Function(UserDataState) _then) = _$UserDataStateCopyWithImpl;
@useResult
$Res call({
 UserDataModel user
});


$UserDataModelCopyWith<$Res> get user;

}
/// @nodoc
class _$UserDataStateCopyWithImpl<$Res>
    implements $UserDataStateCopyWith<$Res> {
  _$UserDataStateCopyWithImpl(this._self, this._then);

  final UserDataState _self;
  final $Res Function(UserDataState) _then;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDataModel,
  ));
}
/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataModelCopyWith<$Res> get user {
  
  return $UserDataModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserDataState].
extension UserDataStatePatterns on UserDataState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserDataState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserDataState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserDataState value)  $default,){
final _that = this;
switch (_that) {
case _UserDataState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserDataState value)?  $default,){
final _that = this;
switch (_that) {
case _UserDataState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserDataModel user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserDataState() when $default != null:
return $default(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserDataModel user)  $default,) {final _that = this;
switch (_that) {
case _UserDataState():
return $default(_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserDataModel user)?  $default,) {final _that = this;
switch (_that) {
case _UserDataState() when $default != null:
return $default(_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _UserDataState implements UserDataState {
  const _UserDataState({required this.user});
  

@override final  UserDataModel user;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataStateCopyWith<_UserDataState> get copyWith => __$UserDataStateCopyWithImpl<_UserDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDataState&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'UserDataState(user: $user)';
}


}

/// @nodoc
abstract mixin class _$UserDataStateCopyWith<$Res> implements $UserDataStateCopyWith<$Res> {
  factory _$UserDataStateCopyWith(_UserDataState value, $Res Function(_UserDataState) _then) = __$UserDataStateCopyWithImpl;
@override @useResult
$Res call({
 UserDataModel user
});


@override $UserDataModelCopyWith<$Res> get user;

}
/// @nodoc
class __$UserDataStateCopyWithImpl<$Res>
    implements _$UserDataStateCopyWith<$Res> {
  __$UserDataStateCopyWithImpl(this._self, this._then);

  final _UserDataState _self;
  final $Res Function(_UserDataState) _then;

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_UserDataState(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDataModel,
  ));
}

/// Create a copy of UserDataState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataModelCopyWith<$Res> get user {
  
  return $UserDataModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on

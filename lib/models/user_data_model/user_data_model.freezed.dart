// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDataModel {

 int get id; String get username; String? get fullname; String get phoneNumber; String? get avatar; DateTime? get dateOfBirthday;
/// Create a copy of UserDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataModelCopyWith<UserDataModel> get copyWith => _$UserDataModelCopyWithImpl<UserDataModel>(this as UserDataModel, _$identity);

  /// Serializes this UserDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDataModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullname, fullname) || other.fullname == fullname)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.dateOfBirthday, dateOfBirthday) || other.dateOfBirthday == dateOfBirthday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,fullname,phoneNumber,avatar,dateOfBirthday);

@override
String toString() {
  return 'UserDataModel(id: $id, username: $username, fullname: $fullname, phoneNumber: $phoneNumber, avatar: $avatar, dateOfBirthday: $dateOfBirthday)';
}


}

/// @nodoc
abstract mixin class $UserDataModelCopyWith<$Res>  {
  factory $UserDataModelCopyWith(UserDataModel value, $Res Function(UserDataModel) _then) = _$UserDataModelCopyWithImpl;
@useResult
$Res call({
 int id, String username, String? fullname, String phoneNumber, String? avatar, DateTime? dateOfBirthday
});




}
/// @nodoc
class _$UserDataModelCopyWithImpl<$Res>
    implements $UserDataModelCopyWith<$Res> {
  _$UserDataModelCopyWithImpl(this._self, this._then);

  final UserDataModel _self;
  final $Res Function(UserDataModel) _then;

/// Create a copy of UserDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? fullname = freezed,Object? phoneNumber = null,Object? avatar = freezed,Object? dateOfBirthday = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirthday: freezed == dateOfBirthday ? _self.dateOfBirthday : dateOfBirthday // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserDataModel].
extension UserDataModelPatterns on UserDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserDataModel value)  $default,){
final _that = this;
switch (_that) {
case _UserDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String username,  String? fullname,  String phoneNumber,  String? avatar,  DateTime? dateOfBirthday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserDataModel() when $default != null:
return $default(_that.id,_that.username,_that.fullname,_that.phoneNumber,_that.avatar,_that.dateOfBirthday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String username,  String? fullname,  String phoneNumber,  String? avatar,  DateTime? dateOfBirthday)  $default,) {final _that = this;
switch (_that) {
case _UserDataModel():
return $default(_that.id,_that.username,_that.fullname,_that.phoneNumber,_that.avatar,_that.dateOfBirthday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String username,  String? fullname,  String phoneNumber,  String? avatar,  DateTime? dateOfBirthday)?  $default,) {final _that = this;
switch (_that) {
case _UserDataModel() when $default != null:
return $default(_that.id,_that.username,_that.fullname,_that.phoneNumber,_that.avatar,_that.dateOfBirthday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserDataModel implements UserDataModel {
  const _UserDataModel({required this.id, required this.username, this.fullname, required this.phoneNumber, this.avatar, this.dateOfBirthday});
  factory _UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);

@override final  int id;
@override final  String username;
@override final  String? fullname;
@override final  String phoneNumber;
@override final  String? avatar;
@override final  DateTime? dateOfBirthday;

/// Create a copy of UserDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataModelCopyWith<_UserDataModel> get copyWith => __$UserDataModelCopyWithImpl<_UserDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDataModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullname, fullname) || other.fullname == fullname)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.dateOfBirthday, dateOfBirthday) || other.dateOfBirthday == dateOfBirthday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,fullname,phoneNumber,avatar,dateOfBirthday);

@override
String toString() {
  return 'UserDataModel(id: $id, username: $username, fullname: $fullname, phoneNumber: $phoneNumber, avatar: $avatar, dateOfBirthday: $dateOfBirthday)';
}


}

/// @nodoc
abstract mixin class _$UserDataModelCopyWith<$Res> implements $UserDataModelCopyWith<$Res> {
  factory _$UserDataModelCopyWith(_UserDataModel value, $Res Function(_UserDataModel) _then) = __$UserDataModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String? fullname, String phoneNumber, String? avatar, DateTime? dateOfBirthday
});




}
/// @nodoc
class __$UserDataModelCopyWithImpl<$Res>
    implements _$UserDataModelCopyWith<$Res> {
  __$UserDataModelCopyWithImpl(this._self, this._then);

  final _UserDataModel _self;
  final $Res Function(_UserDataModel) _then;

/// Create a copy of UserDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? fullname = freezed,Object? phoneNumber = null,Object? avatar = freezed,Object? dateOfBirthday = freezed,}) {
  return _then(_UserDataModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullname: freezed == fullname ? _self.fullname : fullname // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirthday: freezed == dateOfBirthday ? _self.dateOfBirthday : dateOfBirthday // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

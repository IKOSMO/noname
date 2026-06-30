// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
BaseMessageModel _$BaseMessageModelFromJson(
  Map<String, dynamic> json
) {
    return TextMessageModel.fromJson(
      json
    );
}

/// @nodoc
mixin _$BaseMessageModel {

 int get id; int get chatId; int get userId; String get text; String get username; bool get isYou; bool get onServer; DateTime get dateTime;
/// Create a copy of BaseMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseMessageModelCopyWith<BaseMessageModel> get copyWith => _$BaseMessageModelCopyWithImpl<BaseMessageModel>(this as BaseMessageModel, _$identity);

  /// Serializes this BaseMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.text, text) || other.text == text)&&(identical(other.username, username) || other.username == username)&&(identical(other.isYou, isYou) || other.isYou == isYou)&&(identical(other.onServer, onServer) || other.onServer == onServer)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chatId,userId,text,username,isYou,onServer,dateTime);

@override
String toString() {
  return 'BaseMessageModel(id: $id, chatId: $chatId, userId: $userId, text: $text, username: $username, isYou: $isYou, onServer: $onServer, dateTime: $dateTime)';
}


}

/// @nodoc
abstract mixin class $BaseMessageModelCopyWith<$Res>  {
  factory $BaseMessageModelCopyWith(BaseMessageModel value, $Res Function(BaseMessageModel) _then) = _$BaseMessageModelCopyWithImpl;
@useResult
$Res call({
 int id, int chatId, int userId, String text, String username, bool isYou, bool onServer, DateTime dateTime
});




}
/// @nodoc
class _$BaseMessageModelCopyWithImpl<$Res>
    implements $BaseMessageModelCopyWith<$Res> {
  _$BaseMessageModelCopyWithImpl(this._self, this._then);

  final BaseMessageModel _self;
  final $Res Function(BaseMessageModel) _then;

/// Create a copy of BaseMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? chatId = null,Object? userId = null,Object? text = null,Object? username = null,Object? isYou = null,Object? onServer = null,Object? dateTime = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,isYou: null == isYou ? _self.isYou : isYou // ignore: cast_nullable_to_non_nullable
as bool,onServer: null == onServer ? _self.onServer : onServer // ignore: cast_nullable_to_non_nullable
as bool,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BaseMessageModel].
extension BaseMessageModelPatterns on BaseMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TextMessageModel value)?  text,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TextMessageModel() when text != null:
return text(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TextMessageModel value)  text,}){
final _that = this;
switch (_that) {
case TextMessageModel():
return text(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TextMessageModel value)?  text,}){
final _that = this;
switch (_that) {
case TextMessageModel() when text != null:
return text(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int id,  int chatId,  int userId,  String text,  String username,  bool isYou,  bool onServer,  DateTime dateTime)?  text,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TextMessageModel() when text != null:
return text(_that.id,_that.chatId,_that.userId,_that.text,_that.username,_that.isYou,_that.onServer,_that.dateTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int id,  int chatId,  int userId,  String text,  String username,  bool isYou,  bool onServer,  DateTime dateTime)  text,}) {final _that = this;
switch (_that) {
case TextMessageModel():
return text(_that.id,_that.chatId,_that.userId,_that.text,_that.username,_that.isYou,_that.onServer,_that.dateTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int id,  int chatId,  int userId,  String text,  String username,  bool isYou,  bool onServer,  DateTime dateTime)?  text,}) {final _that = this;
switch (_that) {
case TextMessageModel() when text != null:
return text(_that.id,_that.chatId,_that.userId,_that.text,_that.username,_that.isYou,_that.onServer,_that.dateTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TextMessageModel implements BaseMessageModel {
  const TextMessageModel({required this.id, required this.chatId, required this.userId, required this.text, required this.username, required this.isYou, this.onServer = false, required this.dateTime});
  factory TextMessageModel.fromJson(Map<String, dynamic> json) => _$TextMessageModelFromJson(json);

@override final  int id;
@override final  int chatId;
@override final  int userId;
@override final  String text;
@override final  String username;
@override final  bool isYou;
@override@JsonKey() final  bool onServer;
@override final  DateTime dateTime;

/// Create a copy of BaseMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextMessageModelCopyWith<TextMessageModel> get copyWith => _$TextMessageModelCopyWithImpl<TextMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.text, text) || other.text == text)&&(identical(other.username, username) || other.username == username)&&(identical(other.isYou, isYou) || other.isYou == isYou)&&(identical(other.onServer, onServer) || other.onServer == onServer)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chatId,userId,text,username,isYou,onServer,dateTime);

@override
String toString() {
  return 'BaseMessageModel.text(id: $id, chatId: $chatId, userId: $userId, text: $text, username: $username, isYou: $isYou, onServer: $onServer, dateTime: $dateTime)';
}


}

/// @nodoc
abstract mixin class $TextMessageModelCopyWith<$Res> implements $BaseMessageModelCopyWith<$Res> {
  factory $TextMessageModelCopyWith(TextMessageModel value, $Res Function(TextMessageModel) _then) = _$TextMessageModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int chatId, int userId, String text, String username, bool isYou, bool onServer, DateTime dateTime
});




}
/// @nodoc
class _$TextMessageModelCopyWithImpl<$Res>
    implements $TextMessageModelCopyWith<$Res> {
  _$TextMessageModelCopyWithImpl(this._self, this._then);

  final TextMessageModel _self;
  final $Res Function(TextMessageModel) _then;

/// Create a copy of BaseMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chatId = null,Object? userId = null,Object? text = null,Object? username = null,Object? isYou = null,Object? onServer = null,Object? dateTime = null,}) {
  return _then(TextMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,isYou: null == isYou ? _self.isYou : isYou // ignore: cast_nullable_to_non_nullable
as bool,onServer: null == onServer ? _self.onServer : onServer // ignore: cast_nullable_to_non_nullable
as bool,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

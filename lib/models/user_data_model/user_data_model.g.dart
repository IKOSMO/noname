// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    _UserDataModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      fullname: json['fullname'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      avatar: json['avatar'] as String?,
      dateOfBirthday: json['dateOfBirthday'] == null
          ? null
          : DateTime.parse(json['dateOfBirthday'] as String),
    );

Map<String, dynamic> _$UserDataModelToJson(_UserDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullname': instance.fullname,
      'phoneNumber': instance.phoneNumber,
      'avatar': instance.avatar,
      'dateOfBirthday': instance.dateOfBirthday?.toIso8601String(),
    };

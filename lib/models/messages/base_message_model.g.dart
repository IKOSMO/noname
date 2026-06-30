// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessageModel _$TextMessageModelFromJson(Map<String, dynamic> json) =>
    TextMessageModel(
      id: (json['id'] as num).toInt(),
      chatId: (json['chatId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      text: json['text'] as String,
      username: json['username'] as String,
      isYou: json['isYou'] as bool,
      onServer: json['onServer'] as bool? ?? false,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$TextMessageModelToJson(TextMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'userId': instance.userId,
      'text': instance.text,
      'username': instance.username,
      'isYou': instance.isYou,
      'onServer': instance.onServer,
      'dateTime': instance.dateTime.toIso8601String(),
    };

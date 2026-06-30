import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_message_model.freezed.dart';
part 'base_message_model.g.dart';

@freezed
sealed class BaseMessageModel with _$BaseMessageModel {
  const factory BaseMessageModel.text({
    required int id,
    required int chatId,
    required int userId,
    required String text,
    required String username,
    required bool isYou,
    @Default(false) bool onServer,
    required DateTime dateTime,
  }) = TextMessageModel;

  // const factory BaseMessageModel.voice({
  //   required int id,
  //   required int chatId,
  //   required int userId,
  //   required String text,
  //   required String username,
  //   required bool isYou,
  //   @Default(false) bool onServer,
  //   required DateTime dateTime,
  // }) = VoiceMessageModel;

  factory BaseMessageModel.fromJson(Map<String, dynamic> json) =>
      _$BaseMessageModelFromJson(json);
}

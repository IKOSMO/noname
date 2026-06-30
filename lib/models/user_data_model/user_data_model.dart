import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_model.freezed.dart';
part 'user_data_model.g.dart';

@freezed
abstract class UserDataModel with _$UserDataModel {
  const factory UserDataModel({
    required int id,
    required String username,
    String? fullname,
    required String phoneNumber,
    String? avatar,
    DateTime? dateOfBirthday,
  }) = _UserDataModel;

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
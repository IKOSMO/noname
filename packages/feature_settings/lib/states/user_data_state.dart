import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/user_data_model/user_data_model.dart';

part 'user_data_state.freezed.dart';

@freezed
abstract class UserDataState with _$UserDataState {
  const factory UserDataState({required UserDataModel user}) = _UserDataState;
}
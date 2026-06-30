import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/database/app_database.dart';
import 'package:noname/main.dart';
import 'package:noname/models/user_data_model/user_data_model.dart';
import 'package:noname/screens/settings/states/user_data_state.dart';

class UserDataNotifier extends Notifier<UserDataState> {
  @override
  UserDataState build() {
    _loadUser();
    
    return UserDataState(
      user: UserDataModel(
        id: 0,
        username: 'shtabelss',
        fullname: 'Сергей Штабс',
        phoneNumber: '79994444444',
        avatar: null,
        dateOfBirthday: null,
      ),
    );
  }

  Future<void> _loadUser() async {
    final userDao = database.userDao;
    final user = await userDao.getUserById(1);
    if (user != null) {
      final newUser = UserDataModel.fromJson(user.toJson());
      log(newUser.toString());
    } else {
      log('Create new user...');
      final newUser = UserDataModel(
        id: 0,
        username: 'shtabelss',
        fullname: 'Сергей Штабс',
        phoneNumber: '79994444444',
        avatar: null,
        dateOfBirthday: null,
      );
      await userDao.insertUser(
        UsersCompanion.insert(
          username: newUser.username,
          phoneNumber: newUser.phoneNumber,
          fullname: Value(newUser.fullname),
        ),
      );
      await _loadUser();
    }
  }
}

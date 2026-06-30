import 'package:drift/drift.dart';

class Users extends Table {
  // PRIMARY KEY с автоинкрементом
  IntColumn get id => integer().autoIncrement()();

  // Обязательные текстовые поля
  TextColumn get username => text()();
  TextColumn get phoneNumber => text()();

  // Nullable поля
  TextColumn get fullname => text().nullable()();
  TextColumn get avatar => text().nullable()();
  DateTimeColumn get dateOfBirthday => dateTime().nullable()();
}

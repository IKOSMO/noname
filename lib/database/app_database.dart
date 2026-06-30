import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/user_table.dart';
import 'daos/user_dao.dart';


part 'app_database.g.dart';

// 3. Аннотация: перечисляем ВСЕ таблицы и DAO, которые есть в БД
@DriftDatabase(tables: [Users], daos: [UserDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Версия схемы. При изменении таблиц — увеличиваем
  @override
  int get schemaVersion => 1;

  // Миграции (пока пустые, версия 1)
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {},
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));

    return NativeDatabase.createInBackground(file);
  });
}
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/user_table.dart';

part 'user_dao.g.dart';

// Аннотация указывает, с какой таблицей работает этот DAO
@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  /// Получить всех пользователей
  Future<List<User>> getAllUsers() => select(users).get();

  /// Получить пользователя по ID
  Future<User?> getUserById(int id) {
    return (select(users)..where((u) => u.id.equals(id)))
        .getSingleOrNull();
  }

  /// 🔥 РЕАКТИВНОСТЬ: Stream, который обновляется при изменении данных
  Stream<User?> watchUserById(int id) {
    return (select(users)..where((u) => u.id.equals(id)))
        .watchSingleOrNull();
  }

  // ============================================
  // ✍️ ЗАПИСЬ
  // ============================================

  /// Вставить нового пользователя. Возвращает ID.
  Future<int> insertUser(UsersCompanion user) {
    return into(users).insert(user);
  }

  /// Вставить или обновить (если ID уже существует)
  Future<void> upsertUser(UsersCompanion user) {
    return into(users).insertOnConflictUpdate(user);
  }

  /// Обновить существующего пользователя
  Future<bool> updateUser(User user) {
    return update(users).replace(user);
  }

  /// Удалить пользователя
  Future<int> deleteUser(User user) {
    return delete(users).delete(user);
  }
}
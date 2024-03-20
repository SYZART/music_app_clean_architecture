import 'package:openmusic/common/exception.dart';
import 'package:openmusic/data/datasources/db/database_helper.dart';

abstract class AuthLocalDataSource {
  // String? getPassword();
  Future<bool> setAccesToken(String accesToken);
  Future<String?> getAccesToken();
  // Future<bool> setPassword(String password);
  Future<bool> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseHelper databaseHelper;

  AuthLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String?> getAccesToken() async {
    final result = await databaseHelper.getAccessToken();
    return result;
  }

  @override
  Future<bool> logout() async {
    try {
      final result = await databaseHelper.logout();
      return result;
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> setAccesToken(String accesToken) async {
    try {
      final result = await databaseHelper.setAccessToken(accesToken);
      return result;
    } catch (e) {
      throw DatabaseException();
    }
  }
}

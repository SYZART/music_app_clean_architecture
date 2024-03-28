import 'package:openmusic/common/exception.dart';
import 'package:openmusic/data/datasources/db/sql_database_helper.dart';
import 'package:openmusic/data/models/login_model.dart';

abstract class AuthLocalDataSource {
  Future<int> clearUserToken();
  Future<String?> getUserToken(String tokenName);
  Future<String> saveUserToken(DataLoginModel loginModel);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SQLDatabaseHelper sqlDatabaseHelper;

  AuthLocalDataSourceImpl({
    required this.sqlDatabaseHelper,
  });

  @override
  Future<String> saveUserToken(DataLoginModel loginModel) async {
    try {
      await sqlDatabaseHelper.insertUserToken(loginModel);
      return 'Succes Save Token';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<int> clearUserToken() async {
    try {
      return await sqlDatabaseHelper.clearUserTable();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String?> getUserToken(String tokenName) async {
    try {
      return await sqlDatabaseHelper.readUserToken(tokenName);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}

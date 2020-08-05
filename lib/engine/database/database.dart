import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/repository_dao.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, "source.db");

  return openDatabase(path,
      onCreate: (db, version) { db.execute(RepositoryDao.tableSql); },
      version: 1);
}

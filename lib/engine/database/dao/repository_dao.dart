import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:sqflite/sqflite.dart';
import '../database.dart';

class RepositoryDao {
  static const String tableSql = "CREATE TABLE $_tableName("
      "$_id INTEGER PRIMARY KEY, "
      "$_name TEXT, "
      "$_workDirectory TEXT)";

  static const String _tableName = "repository";
  static const String _id = "id";
  static const String _workDirectory = "workDirectory";
  static const String _name = "name";

  Future<int> save(Repository repository) async {
    final Database db = await getDatabase();
    Map<String, dynamic> repositoryMap = _toMap(repository);

    return db.insert(_tableName, repositoryMap);
  }

  Future<List<Repository>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Repository> repositories = _toList(result);

    return repositories;
  }

  Map<String, dynamic> _toMap(Repository repository) {
    final Map<String, dynamic> repositoryMap = Map();
    repositoryMap[_name] = repository.name;
    repositoryMap[_workDirectory] = repository.workDirectory;

    return repositoryMap;
  }

  List<Repository> _toList(List<Map<String, dynamic>> result) {
    final List<Repository> repositories = List();
    for(Map<String, dynamic> map in result) {
      final Repository repository = Repository(
          map[_name],
          map[_workDirectory],
          id: map[_id]
      );
      repositories.add(repository);
    }

    return repositories;
  }
}

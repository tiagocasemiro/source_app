import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:sembast/sembast.dart';
import '../database.dart';

class RepositoryDao {
  static const String tableName = "git_repositories";
  final String _id = "id";
  final String _workDirectory = "workDirectory";
  final String _name = "name";
  final StoreRef _store = intMapStoreFactory.store(tableName);

  Future<bool> save(Repository repository) async {
    bool exist = await _exist(repository);
    if(!exist) {
      final Database db = await getDatabase();
      Map<String, dynamic> repositoryMap = _toMap(repository);
      var saved =  await _store.add(db, repositoryMap);

      print("saved");
      print(saved);

      return saved != null;
    }

    return false;
  }

  Future<List<Repository>> findAll() async {
    final Database db = await getDatabase();
    var records = await _store.find(db);
    List<Repository> repositories = List();
    records.forEach((item) {
      final Repository repository = Repository(item[_name],item[_workDirectory]);
      repositories.add(repository);
    });

    return repositories;
  }

  Future<int> delete(Repository repository) async {
    final Database db = await getDatabase();
    var filter = Filter.equals(_workDirectory, repository.workDirectory) &
      Filter.equals(_name, repository.name);
    var finder = Finder(filter: filter);

    return await _store.delete(db, finder: finder);
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
          map[_workDirectory]
      );
      repositories.add(repository);
    }

    return repositories;
  }

  Future<bool> _exist(Repository repository) async {
    final Database db = await getDatabase();
    var filter = Filter.equals(_workDirectory, repository.workDirectory) &
    Filter.equals(_name, repository.name);
    var finder = Finder(filter: filter);
    var result = await _store.findFirst(db, finder: finder);

    print("exist");
    print(result);

    return result != null;
  }
}

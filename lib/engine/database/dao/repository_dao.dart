import 'package:source_app/engine/database/database.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:sembast/sembast.dart';


class RepositoryDao {
  static const String tableName = "git_repositories";
  final String _workDirectory = "workDirectory";
  final String _name = "name";
  final String _credentials = "credentials";
  final String _username = "username";
  final String _password = "password";
  final String _url = "url";
  final StoreRef _store = intMapStoreFactory.store(tableName);

  Future<bool> save(Repository repository) async {
    bool existRepo = await exist(repository);
    if(!existRepo) {
      final Database db = await getDatabase();
      Map<String, dynamic> repositoryMap = _toMap(repository);
      var saved =  await _store.add(db, repositoryMap);

      return saved != null;
    }

    return false;
  }

  Future<int> update(Repository repository) async {
    bool existRepo = await exist(repository);
    if(existRepo) {
      var filter = Filter.equals(_workDirectory, repository.workDirectory);
      var finder = Finder(filter: filter);
      final Database db = await getDatabase();
      Map<String, dynamic> repositoryMap = _toMap(repository);
      var saved =  await _store.update(db, repositoryMap, finder: finder);

      return saved;
    }

    return 0;
  }

  Future<List<Repository>> findAll() async {
    final Database db = await getDatabase();
    var records = await _store.find(db);
    List<Repository> repositories = List();
    records.forEach((item) {
      final Repository repository = Repository(item[_name],item[_workDirectory]);
      repository.credentials = item[_credentials];
      repository.username = item[_username];
      repository.password = item[_password];
      repository.url = item[_url];
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
    repositoryMap[_credentials] = repository.credentials;
    repositoryMap[_username] = repository.username;
    repositoryMap[_password] = repository.password;
    repositoryMap[_url] = repository.url;

    return repositoryMap;
  }

  // ignore: unused_element
  List<Repository> _toList(List<Map<String, dynamic>> result) {
    final List<Repository> repositories = List();
    for(Map<String, dynamic> map in result) {
      final Repository repository = Repository(
          map[_name],
          map[_workDirectory]
      );
      repository.credentials = map[_credentials];
      repository.username = map[_username];
      repository.password = map[_password];
      repository.url = map[_url];
      repositories.add(repository);
    }

    return repositories;
  }

  Future<bool> exist(Repository repository) async {
    final Database db = await getDatabase();
    var filter = Filter.equals(_workDirectory, repository.workDirectory);
    var finder = Finder(filter: filter);
    var result = await _store.findFirst(db, finder: finder);

    return result != null;
  }
}

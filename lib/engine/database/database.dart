import 'package:sembast/sembast_io.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<Database> getDatabase() async {
  var dir = await getApplicationDocumentsDirectory();
  await dir.create(recursive: true);
  var dbPath = join(dir.path, 'source.db');
  var db = await databaseFactoryIo.openDatabase(dbPath, version: 1, onVersionChanged: (db, oldVersion, newVersion) async {
    if (oldVersion == 0) {
      // Apply initial configs on first version of database
    }
  });

  return db;
}

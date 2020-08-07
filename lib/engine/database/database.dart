import 'package:sembast/sembast_io.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<Database> getDatabase() async {
  var dir = await getApplicationDocumentsDirectory();
  await dir.create(recursive: true);
  var dbPath = join(dir.path, 'source.db');
  var store = intMapStoreFactory.store('shop'); // TODO preload data
  var db = await databaseFactoryIo.openDatabase(dbPath, version: 1, onVersionChanged: (db, oldVersion, newVersion) async {
    if (oldVersion == 0) { //TODO Firstopen db
      await store.add(db, {'name': 'Lamp', 'price': 10});
      await store.add(db, {'name': 'Chair', 'price': 15});
    }
  });

  return db;
}

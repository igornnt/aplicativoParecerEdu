
class Db {

//  DbDatabaseProvider._();
//
//  static final dbDatabaseProvider db = dbDatabaseProvider._();
//
//  Database _database;
//
//  Future<Database> get database async {
//    if (_database != null) return _database;
//    _database = await getDatabaseInstance();
//    return _database;
//  }
//
//  Future<Database> getDatabaseInstance() async {
//    Directory directory = await getApplicationDocumentsDirectory();
//    String path = join(directory.path, "school.db");
//    return await openDatabase(path, version: 1,
//        onCreate: (Database db, int version) async {
//          await db.execute("CREATE TABLE School ("
//              "id integer primary key AUTOINCREMENT,"
//              "name TEXT"
//              ")");
//        });
//  }

}
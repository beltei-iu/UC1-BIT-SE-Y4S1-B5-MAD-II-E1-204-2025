
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {

  // DB Name
  String dbName = "visitme.db";

  // Create Instance
  static final DBManager instance = DBManager._init();

   // Private Constructor
  DBManager._init();

  Future<Database> get database async {

    // Get Path
    final dbPath = await getDatabasesPath();

    // Joint DB Path
    //final path = "$dbPath/$dbName";
    final path = join(dbPath, dbName);
    // Open DB
    return await openDatabase(path, version: 1, onCreate: _onCreateTable);
  }

  Future<void> _onCreateTable(Database db, int version) async{
    String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    String textType = "TEXT";
    String doubleType = "DOUBLE";
    String intType = "INTEGER";

    final productTableSql = ''' 
      CREATE TABLE tbl_product(
        id ${idType},
        name ${textType},
        price ${doubleType},
        quantity ${intType}
      )
    ''';
    await db.execute(productTableSql);

    final categoryTableSql = '''
      CREATE TABLE tbl_category(
        id ${idType},
        name ${textType}
      )
    ''';
    await db.execute(categoryTableSql);
  }
}
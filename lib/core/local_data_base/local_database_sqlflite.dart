
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:store_app2/view_models/product_view_model.dart';

class SQLDatabase{

  static Database? _db;
  Future<Database?> get db async {
    if(_db == null){
      _db = await intialDb();
      return _db;
    }else{
      return _db;
    }
  }

  Future<Database>intialDb()async{
      String getDatabasePath = await getDatabasesPath();
      String path = join(getDatabasePath, "ElectronicStore.db");
      Database myDb = await openDatabase(path, onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
      return myDb;
  }
  _onUpgrade(Database db, int oldVersion, int newVersion)async{
    print("*****************/ => onUpgrade $newVersion => /*******************");
  }
  _onCreate(Database db, int version)async{
    await db.execute('CREATE TABLE favorite (id INTEGER PRIMARY KEY AUTOINCREMENT, userId TEXT NOT NULL, productId INTEGER NOT NULL, price INTEGER, title TEXT, subTitle TEXT, description TEXT, image TEXT)');
    await db.execute('CREATE TABLE "cart" (id INTEGER PRIMARY KEY AUTOINCREMENT, userId TEXT NOT NULL, productId INTEGER NOT NULL, price INTEGER, title TEXT, subTitle TEXT, description TEXT, image TEXT)');
    print("*************** you create table favorite & cart ****************");
  }

  Future<List<Map>> readData(sql)async{
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }
  Future<int> insertData(String sql)async{
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }
  Future<int> updateData(String sql)async{
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }
  Future<int> deleteData(String sql)async{
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }


  myDeleteDatabase()async{
    String getDatabasePath = await getDatabasesPath();
    String path = join(getDatabasePath, "ElectronicStore.db");
    await deleteDatabase(path);
  }
}
import 'package:news_circle/utils/app_logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'saved_articles.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE articles (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          status TEXT,                          
          code TEXT,                            
          message TEXT,                    
          source_name TEXT,                     
          author TEXT,                          
          title TEXT,                           
          description TEXT,                     
          url TEXT,                             
          urlToImage TEXT,                    
          publishedAt TEXT,                    
          content TEXT                          
      )
    ''');
    await db.execute('''
      CREATE TABLE sources (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
      )
      ''');
    await db.execute('''
      ALTER TABLE articles ADD COLUMN source_id INTEGER REFERENCES sources(id)
    ''');
  }

  Future<List<Map<String, Object?>>> getSavedArticles() async {
    try {
      final db = await getDatabase();
      return await db.query('articles');
    } catch (e) {
      AppLogger.e('[Database][Exception]: $e');
      return [];
    }
  }

  Future<int> saveArticle(Map<String, dynamic> mp) async {
    try {
      final db = await getDatabase();
      AppLogger.i('[Map]: $mp');
      var sourceMap = mp['source'] as Map<String, dynamic>;

      if (sourceMap['id'] == null) {
        sourceMap.remove('id');
      }
      final addSource = await db.insert('sources', sourceMap);
      if (addSource > 0) {
        mp.remove('source');
        final source = await db.rawQuery(
            'SELECT * FROM sources WHERE name = ?', [sourceMap['name']]);
        if (source.isEmpty) {
          throw Exception('No source found');
        }
        AppLogger.i('[Source]: $source');
        mp.addAll(
          {
            "source_id": source.first['id'],
            "source_name": source.first['name']
          },
        );
        return await db.insert('articles', mp);
      }
      return 0;
    } catch (e) {
      AppLogger.e('[Database][Exception]: $e');
      return 0;
    }
  }

  Future<int> removeArticle(int id) async {
    try {
      final db = await getDatabase();

      return await db.delete('articles', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      AppLogger.e('[Database][Exception]: $e');
      return 0;
    }
  }
}

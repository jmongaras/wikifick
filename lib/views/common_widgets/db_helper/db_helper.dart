import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../models/wikipedia_response_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper.getInstance() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'liked_posts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE liked_posts (
            pageId TEXT PRIMARY KEY,
            title TEXT,
            extract TEXT,
            imageUrl TEXT,
            fullUrl TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertLikedPost(WikiPageModel post) async {
    final db = await database;
    await db.insert(
      'liked_posts',
      {
        'pageId': post.pageId,
        'title': post.title,
        'extract': post.extract,
        'imageUrl': post.imageUrl,
        'fullUrl': post.fullUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteLikedPost(String pageId) async {
    final db = await database;
    await db.delete('liked_posts', where: 'pageId = ?', whereArgs: [pageId]);
  }

  Future<bool> isPostLiked(String pageId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
    await db.query('liked_posts', where: 'pageId = ?', whereArgs: [pageId]);
    return maps.isNotEmpty;
  }

  Future<List<WikiPageModel>> getLikedPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('liked_posts');
    return List.generate(maps.length, (i) {
      return WikiPageModel(
        pageId: maps[i]['pageId'],
        title: maps[i]['title'],
        extract: maps[i]['extract'],
        imageUrl: maps[i]['imageUrl'],
        fullUrl: maps[i]['fullUrl'],
        isLiked: true,
      );
    });
  }
}

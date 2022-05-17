import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PostFavorite {
  final String id;
  final bool isFavorite;

  PostFavorite(this.id, this.isFavorite);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isFavorite': isFavorite,
    };
  }
}

class VideoFavorite {
  final String id;
  final bool isFavorite;

  VideoFavorite(this.id, this.isFavorite);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isFavorite': isFavorite,
    };
  }
}

class FavoriteDatabase {
  static final FavoriteDatabase _favoriteDatabase =
      new FavoriteDatabase._internal();

  Database db;

  static FavoriteDatabase get() {
    return _favoriteDatabase;
  }

  FavoriteDatabase._internal();

  Future<bool> isPostFavorite(String id) async {
    var result = await db.rawQuery('SELECT * FROM posts WHERE id = "$id"');
    if (result.length == 0) return Future<bool>.value(false);
    return Future<bool>.value(result[0]['isFavorite'] == 1 ? true : false);
  }

  Future<bool> isVideoFavorite(String id) async {
    var result = await db.rawQuery('SELECT * FROM videos WHERE id = "$id"');
    if (result.length == 0) return Future<bool>.value(false);
    return Future<bool>.value(result[0]['isFavorite'] == 1 ? true : false);
  }

  Future<List<dynamic>> getAllTopicFavorites() async {
    var result = await db.rawQuery('SELECT * FROM posts WHERE isFavorite = 1');
    return Future<List<dynamic>>.value(result);
  }

  Future<List<dynamic>> getAllVideoFavorites() async {
    var result = await db.rawQuery('SELECT * FROM videos WHERE isFavorite = 1');
    return Future<List<dynamic>>.value(result);
  }

  Future updateVideoFavorite(VideoFavorite videoFavorite) async {
    await db.insert(
      'videos',
      videoFavorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future updatePostFavorite(PostFavorite postFavorite) async {
    await db.insert(
      'posts',
      postFavorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demo.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          "CREATE TABLE posts (id STRING PRIMARY KEY, isFavorite BIT)");
      await db.execute(
          "CREATE TABLE videos (id STRING PRIMARY KEY, isFavorite BIT)");
    });
  }
}

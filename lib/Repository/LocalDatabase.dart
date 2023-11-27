import 'dart:async';
import 'dart:io';
import 'package:poetry/Helper/Util/LocalDatabaseHelper.dart';
import 'package:poetry/Repository/DataSource.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;

class LocalDatabase implements DataSource {
  Database? _database;

  // 单例模式
  LocalDatabase._();
  static LocalDatabase localDatabase = LocalDatabase._();

  // 引入辅助类
  final LocalDatabaseHelper helper = const LocalDatabaseHelper();

  // 与数据库建立连接
  @override
  Future<void> connect(ConnectionArgument? connectionArgument) async {
    if (_database != null) return;
    helper.setupDatabase();

    // 数据库文件所在的文件夹路径
    String dbDirPath = await helper.getDbDirPath();

    // 数据库文件的路径
    String dbPath = path.join(dbDirPath, 'sqlite.db');

    //当文件夹中未发现数据库时，会创建数据库并触发 onCreate 回调
    //当数据库的版本变化时，会触发 onUpgrade 回调；
    //数据库打开成功后，会触发 onOpen 函数通知。
    OpenDatabaseOptions options = OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onOpen: _onOpen);

    // 在Windows/Linux下，与数据库建立连接
    if (Platform.isWindows || Platform.isLinux) {
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      _database = await databaseFactory.openDatabase(
        dbPath,
        options: options,
      );
      return;
    }

    // 在Android、Ios、Mac下，与数据库建立连接
    _database = await openDatabase(
      dbPath,
      version: options.version,
      onCreate: options.onCreate,
      onUpgrade: options.onUpgrade,
      onOpen: options.onOpen,
    );
  }

  // 释放连接
  @override
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    // 这里执行创建表的逻辑
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {}

  FutureOr<void> _onOpen(Database db) {
    // 这里依赖注入Dao对象
  }
}

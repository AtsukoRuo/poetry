import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

class LocalDatabaseHelper {
  static const String dirName = 'poetry_databases_HYS7GV4U';

  const LocalDatabaseHelper();

  void setupDatabase() {
    // 加载Windows平台的DDL文件
    if (Platform.isWindows) {
      String location = Directory.current.path;

      //dll文件已经放在了项目的根目录中
      _windowsInit(join(location, 'sqlite3.dll'));
    }
  }

  void _windowsInit(String path) {
    //sqlite模块中的open方法
    open.overrideFor(OperatingSystem.windows, () {
      try {
        return DynamicLibrary.open(path);
      } catch (e) {
        stderr.writeln('Failed to load sqlite3.dll at $path');
        rethrow;
      }
    });

    sqlite3.openInMemory().dispose();
  }

  // 获取数据库文件所在文件夹的默认路径，如果不存在则创建一个
  Future<String> getDbDirPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    String dirPath = join(appDocDir.path, dirName);

    // 创建文件夹
    Directory result = Directory(dirPath);
    if (!result.existsSync()) {
      result.createSync(recursive: true);
    }

    return dirPath;
  }
}

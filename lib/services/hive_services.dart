import 'package:hive/hive.dart';

class HiveService{

  static final _box = Hive.box("TaskApp");

  static void saveName(String name){
    name = name.trim();
    name = name[0].toUpperCase() + name.substring(1);
    _box.put("username", name);
  }

  static String? getName(){
    return _box.get("username");
  }

}
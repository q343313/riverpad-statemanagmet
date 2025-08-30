

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riverpadstate/models/moodmodels.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDataBase {

    Database?_db;

  Future<Database?>get db async{
    if(_db != null){
      return _db;
    }else{
      _db =await initializedatabase();
      return _db;
    }
}

initializedatabase()async{
Directory directry = await getApplicationDocumentsDirectory();
var paths = join(directry.path,"user.db");
var database = await openDatabase(paths,version: 1,onCreate: _oncreate);
return database;

}

Future _oncreate(Database db,int version)async{
    await db.execute(
      "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,work TEXT NOT NULL,image TEXT NOT NULL)"
    );
}


Future<MoodModels>adduser(MoodModels moodmodel)async{
    final appclient = await db;
    await appclient!.insert("user", moodmodel.toMap());
    return moodmodel;
}

Future<List<MoodModels>>getdata()async{
    final appclien = await db;
    final List<Map<String,dynamic>>query = await appclien!.query("user");
    return query.map((e)=>MoodModels.fromMap(e)).toList();
}

Future<void>deleteuser(int id)async{
    final appclient = await db;
    await appclient!.delete("user",where: "id = ?",whereArgs: [id]);
}

Future<void>deletelistuser(List<int> userid )async{
    final appclien = await db;
    for (int id in userid){
      await appclien!.delete("user",where: "id = ?",whereArgs: [id]);
    }
}

Future<void>updateuserdata(MoodModels moodemodel)async{
    final  appclie = await db;
    await appclie!.update("user", moodemodel.toMap(),where: "id = ?",whereArgs: [moodemodel.id]);
}

}
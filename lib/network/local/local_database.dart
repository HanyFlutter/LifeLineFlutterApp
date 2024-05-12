import 'package:sqflite/sqflite.dart';
Database? db ;

Future openMyDatabase ()async{
  db = await openDatabase('LifeLine',version: 1,
  onCreate: (db,version)async {
   await db.execute(
       'CREATE TABLE user(id INTEGER PRIMARY KEY ,bloodType TEXT , birthdate TEXT , firstname TEXT , lastname TEXT , gender TEXT , government TEXT , city TEXT , password TEXT , disease TEXT, reciverDate TEXT , phoneNumber TEXT , email TEXT ,reminderDonation TEXT)');
   print('isCreated');

  },
   onOpen: (db){
   print('isOpened');
   }
  );
  return db;
}
Future deleteMyDatabase()async{
 await deleteDatabase('LifeLine');
print('db is deleted');

}
Future insertInMyDatabase()async{
  await db?.transaction((txn)async {
var d1=await txn.rawInsert('insert into user (firstname , lastname)values("hany","mahmoud")');
print('inserted $d1');
  });
}
Future deleteFromDatabase()async{
  await db?.transaction((txn)async {
    var d1=await txn.rawDelete('delete from user where firstname ="hany"');
    print('deleted $d1');
  });
}
Future searchInDatabase()async{
  await db?.transaction((txn)async {
    var d1=await txn.rawQuery('select * from user');
    print('selected $d1');
  });
}
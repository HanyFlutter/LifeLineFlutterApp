import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{
 static  SharedPreferences? prefs ;
   static Future init()async{
   return  prefs = await SharedPreferences.getInstance();
   }
 static Future setInt({required String key , required int value})async{
   return   await prefs!.setInt(key, value);

 }
 static Future setBool({required String key , required bool value})async{
   return    await prefs!.setBool(key, value);

 }
 static Future setDouble({required String key , required double value})async{
   return    await prefs!.setDouble(key, value);

 }
 static Future setString({required String key , required String value})async{
   return   await prefs!.setString(key, value);

 }
 static Future setStringList({required String key , required List<String> value})async{
   return    await prefs!.setStringList(key, value);

 }
 static Future getInt({required String key })async{
   return    prefs!.getInt(key);

 }
 static Future getBool({required String key })async{
   return    prefs!.getBool(key);

 }
 static Future getDouble({required String key })async{
   return    prefs!.getDouble(key);

 }
 static Future getString({required String key })async{
   return    prefs!.getString(key);

 }
 static Future getStringList({required String key })async{
   return    prefs!.getStringList(key);

 }
 static Future remove()async{
   return     await prefs!.clear();


 }

}
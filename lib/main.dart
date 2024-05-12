import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/layout/home_screen/user_home_screen/user_home_screen.dart';
import 'package:lifeline/shared/components/intro_screen.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/modules/login_screen/login_screen.dart';
import 'package:lifeline/network/local/local_database.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/app_bar.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import 'package:lifeline/shared/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
 await SharedPreferencesHelper.init();
  rememberMe =
      (
          await SharedPreferencesHelper.getBool(key: 'rememberMe')) ?? false;
  email = await SharedPreferencesHelper.getString(key: 'email') ?? '';
  password = await SharedPreferencesHelper.getString(key: 'password') ?? '';
  userType = await SharedPreferencesHelper.getString(key: 'loginAs') ?? '';
  userID=await SharedPreferencesHelper.getString(key: 'userID') ?? '';
    userToken=await SharedPreferencesHelper.getString(key: 'userToken') ?? '';
  DioHelper.dio.options.connectTimeout = Duration(milliseconds: 100000);
print("user id from main $userID usertoken $userToken userType $userType remember me $rememberMe");


  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LifeLine',
      theme: ThemeData(
        fontFamily: 'beINBlack',
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    openMyDatabase().then((value) => print(value)).catchError((val) {
      print('the error is ${val.toString()}');
    });



  }

  @override
  Widget build(BuildContext context) {

    Map toController = {
      phoneNumberRegis: phoneNumberRegistration.value.text,
      passwordRegis: passwordRegistration.value.text,
      rewritePasswordRegis: rewritePasswordRegistration.value.text,
      firstNameRegis: firstNameRegistration.value.text,
      lastNameRegis: lastNameRegistration.value.text,
      emailAddressRegis: emailAddressRegistration.value.text,
      passwordLog: passwordLogin.value.text,
      donationTimesCo: donationTimesController.value.text,
      birthDayRegis: birthDayRegistration.value.text,
      emailAddressLog: emailAddressLogin.value.text,
    };

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IntroScreen(),
      ),
    );
  }
}

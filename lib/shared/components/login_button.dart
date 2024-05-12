import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifeline/layout/home_screen/blood_bank_home_screen/blood_bank_home_screen.dart';
import 'package:lifeline/layout/home_screen/hospital_home_screen/hospital_home_screen.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import '../../layout/home_screen/user_home_screen/user_home_screen.dart';
import '../../shared//constants.dart';

Widget loginButton(
    {required String text,
    required double width,
    required BuildContext context}) {
  return Container(
    width: width,
    child: ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 2, 88, 5))),
      onPressed: () async {
        if (formKeyLogin.currentState!.validate()) {
          Map loginJsonToApi = {
            "email": emailAddressLogin.value.text,
            "password": passwordLogin.value.text,
          };
          print(loginJsonToApi);
          Response response;

          if (selectedItemJoinAsLogin == 'شخصي') {
            try {
              response = await DioHelper.postData(
                  url: 'user/signIn', data: loginJsonToApi);
              userAndTokenFromApiLoginPost = response.data;
              print("from login screen  $userAndTokenFromApiLoginPost");
              if (rememberMe == true) {
                await SharedPreferencesHelper.setString(
                    key: 'email', value: emailAddressLogin.text);
                await SharedPreferencesHelper.setString(
                    key: 'password', value: passwordLogin.text);
                await SharedPreferencesHelper.setString(
                    key: 'loginAs', value: selectedItemJoinAsLogin);
                await SharedPreferencesHelper.setString(
                    key: 'userID',
                    value: userAndTokenFromApiLoginPost!["userID"]);
                await SharedPreferencesHelper.setString(
                    key: 'userToken',
                    value: userAndTokenFromApiLoginPost!["token"]);
              }
              try {
                response =
                    await DioHelper.getData(url: 'user/profile', header: {
                  "authentication": (userAndTokenFromApiLoginPost!["token"])
                }, data: {
                  "userID": (userAndTokenFromApiLoginPost!["userID"]).toString()
                });
                objectFromApiLoginPost = response.data;
                print("from login screen  $objectFromApiLoginPost");
                loginReaspons = proccessOfRegistrationReasponse(
                    objectFromApiLoginPost!["user"]);
                constTitle = loginReaspons!["firstName"];
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => UserHomeScreen(loginReaspons,title:constTitle,userAndTokenFromApiLoginPos:userAndTokenFromApiLoginPost!),
                ));

              } catch (er) {
                print(er.toString());
                showToast(context);

              }
            } catch (e) {
              print('from catch :  ${e}');
              showToast(context);

            }
          } else if (selectedItemJoinAsLogin == 'بنك دم') {
  try {
  response = await DioHelper.postData(
  url: 'bloodBank/signIn', data: loginJsonToApi);
  userAndTokenFromApiLoginPost = response.data;
  print("from login screen  $userAndTokenFromApiLoginPost");
  if (rememberMe == true) {
  await SharedPreferencesHelper.setString(
  key: 'email', value: emailAddressLogin.text);
  await SharedPreferencesHelper.setString(
  key: 'password', value: passwordLogin.text);
  await SharedPreferencesHelper.setString(
  key: 'loginAs', value: selectedItemJoinAsLogin);
  await SharedPreferencesHelper.setString(
  key: 'userID',
  value: userAndTokenFromApiLoginPost!["bloodBankID"]);
  await SharedPreferencesHelper.setString(
  key: 'userToken',
  value: userAndTokenFromApiLoginPost!["token"]);
  await SharedPreferencesHelper.setString(
  key: 'isOwner',
  value: userAndTokenFromApiLoginPost!["isOwner"]);
  }
  try {
  response =
  await DioHelper.getData(url: 'bloodBank/profile', header: {
  "authentication": (userAndTokenFromApiLoginPost!["token"])
  }, data: {

  "bloodBankID": userAndTokenFromApiLoginPost!["bloodBankID"],
  "isOwner":userAndTokenFromApiLoginPost!["isOwner"]
  });
  objectFromApiLoginPost = response.data;
  print("from login screen  $objectFromApiLoginPost");
  loginReaspons = processHospitalRegistrationRespond(
  objectFromApiLoginPost!["bloodBank"]);
  print("from login $loginReaspons");
  Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (context) => BloodBankHomeScreen(goverCode: goverCode,cityCode: cityCode,objectFromRegistration: loginReaspons,userAndTokenFromApiLoginPos:userAndTokenFromApiLoginPost,),
  ));
  }  catch (er) {
  print(er.toString());
  showToast(context);

  }
  } catch (e) {
  print('from catch :  ${e}');
  showToast(context);

  }

          } else {
            try {
              response = await DioHelper.postData(
                  url: 'hospital/signIn', data: loginJsonToApi);
              userAndTokenFromApiLoginPost = response.data;
              print("from login screen  $userAndTokenFromApiLoginPost");
              if (rememberMe == true) {
                await SharedPreferencesHelper.setString(
                    key: 'email', value: emailAddressLogin.text);
                await SharedPreferencesHelper.setString(
                    key: 'password', value: passwordLogin.text);
                await SharedPreferencesHelper.setString(
                    key: 'loginAs', value: selectedItemJoinAsLogin);
                await SharedPreferencesHelper.setString(
                    key: 'userID',
                    value: userAndTokenFromApiLoginPost!["hospitalID"]);
                await SharedPreferencesHelper.setString(
                    key: 'userToken',
                    value: userAndTokenFromApiLoginPost!["token"]);
                await SharedPreferencesHelper.setString(
                    key: 'isOwner',
                    value: userAndTokenFromApiLoginPost!["isOwner"]);
              }
              try {
                response =
                await DioHelper.getData(url: 'hospital/profile', header: {
                  "authentication": (userAndTokenFromApiLoginPost!["token"])
                }, data: {

                  "hospitalID": userAndTokenFromApiLoginPost!["hospitalID"],
                  "isOwner":userAndTokenFromApiLoginPost!["isOwner"]
                });
                objectFromApiLoginPost = response.data;
                print("from login screen  $objectFromApiLoginPost");
                loginReaspons = processHospitalRegistrationRespond(
                    objectFromApiLoginPost!["hospital"]);
                print("from login $loginReaspons");
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HospitalHomeScreen(goverCode: goverCode,cityCode: cityCode,objectFromRegistration: loginReaspons,userAndTokenFromApiLoginPos:userAndTokenFromApiLoginPost,),
                ));
              }  catch (er) {
                print(er.toString());
                showToast(context);

              }
            } catch (e) {
              print('from catch :  ${e}');
              showToast(context);

            }

          }
        }
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
  );
}


Widget registerButton(BuildContext context){
   return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 2, 88, 5))),
          onPressed: () async {
            Map registrationJsonToApi ;
            if (formKeyUserRegister.currentState!.validate()) {


                if (selectedItemJoinAsRegistration == 'شخصي') {
                  registrationJsonToApi = {
                    "firstName": firstNameRegistration.value.text.toString(),
                    "lastName": lastNameRegistration.value.text.toString(),
                    "email": emailAddressRegistration.value.text.toString(),
                    "password": passwordRegistration.value.text.toString(),
                    "birthDate": birthDayRegistration.value.text.toString(),
                    "gender": selectedGenderItemCode.toString(),
                    "phone": phoneNumberRegistration.value.text.toString(),
                    "bloodType": selectedBloodTypeMenu.toString(),
                    "gov": goverCode.toString(),
                    "city": cityCode.toString(),
                    "disease": listOfDiseasesSelectedValue,
                    "donationTimes": donationTimes
                  };
                  Response response;
                  try {
                    response = await DioHelper.postData(
                        url: 'user', data: registrationJsonToApi);
                    objectFromApiRegisrationPost = response.data;
                    print(objectFromApiRegisrationPost);
                    registrationReasponse = proccessOfRegistrationReasponse(
                      objectFromApiRegisrationPost);

                    constTitle = objectFromApiRegisrationPost["firstName"];
    Map loginJsonToApi = {
      "email": emailAddressRegistration.value.text,
      "password": passwordRegistration.value.text,
    };

  try {
  response = await DioHelper.postData(
  url: 'user/signIn', data: loginJsonToApi);
  userAndTokenFromApiLoginPost = response.data;
  print("from login screen  $userAndTokenFromApiLoginPost");
  if (rememberMe == true) {
  await SharedPreferencesHelper.setString(
  key: 'email', value: emailAddressLogin.text);
  await SharedPreferencesHelper.setString(
  key: 'password', value: passwordLogin.text);
  await SharedPreferencesHelper.setString(
  key: 'loginAs', value: selectedItemJoinAsLogin);
  await SharedPreferencesHelper.setString(
  key: 'userID',
  value: userAndTokenFromApiLoginPost!["userID"]);
  await SharedPreferencesHelper.setString(
  key: 'userToken',
  value: userAndTokenFromApiLoginPost!["token"]);
  }
  try {
  response =
  await DioHelper.getData(url: 'user/profile', header: {
  "authentication": (userAndTokenFromApiLoginPost!["token"])
  }, data: {
  "userID": (userAndTokenFromApiLoginPost!["userID"]).toString()
  });
  objectFromApiLoginPost = response.data;
  print("from login screen  $objectFromApiLoginPost");
  loginReaspons = proccessOfRegistrationReasponse(
  objectFromApiLoginPost!["user"]);
  constTitle = loginReaspons!["firstName"];
  Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (context) => UserHomeScreen(loginReaspons,title:constTitle,userAndTokenFromApiLoginPos:userAndTokenFromApiLoginPost!),
  ));
  } catch (er) {
    print(er.toString());
    showToast(context);
  }
  } catch (er) {
    showToast(context);

    print(er.toString());
  }
  } catch (e) {
                    showToast(context);
                    print('from catch :  ${e}');
  }}
            }


          },
          child: Text(
            'تسجيل',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
}
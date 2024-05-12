
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/layout/home_screen/hospital_home_screen/hospital_home_screen.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import 'package:lifeline/shared/constants.dart';

class HospitalRegistrationButton extends StatefulWidget {
  const HospitalRegistrationButton({super.key});

  @override
  State<HospitalRegistrationButton> createState() => _HospitalRegistrationButtonState();
}

class _HospitalRegistrationButtonState extends State<HospitalRegistrationButton> {
  @override
  Widget build(BuildContext context) {
    return  hospitalRegisterButton();
  }

  Widget hospitalRegisterButton() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 2, 88, 5))),
          onPressed: () async {
            Map hospitalRegistrationJsonToApi;
            if (formKeyHospitalRegister.currentState!.validate()) {
              hospitalRegistrationJsonToApi = {
                "name": hospitalsMap["$goverCode"]![cityIndex][4],
                "email": emailAddressRegistrationHospital.text,
                "password": passwordRegistrationHospital.text,
                "phone": "022580947",
                "gov": hospitalsMap["$goverCode"]![cityIndex][1],
                "city": hospitalsMap["$goverCode"]![cityIndex][3],
                "addressDescription": hospitalsMap["$goverCode"]![cityIndex][5],
              };
              Response response;
              try {
                response = await DioHelper.postData(
                    url: 'hospital', data: hospitalRegistrationJsonToApi);
                objectFromApiRegisrationPost = response.data;
                print("from post first object $objectFromApiRegisrationPost");
                registrationReasponse = proccessOfRegistrationReasponse(
                    objectFromApiRegisrationPost);

                Map loginJsonToApi = {
                  "email": emailAddressRegistrationHospital.value.text,
                  "password": passwordRegistrationHospital.value.text,
                };
                try {
                  response = await DioHelper.postData(
                      url: 'hospital/signIn', data: loginJsonToApi);

                  userAndTokenFromApiLoginPost = response.data;
                  print("from login screen user and token  $userAndTokenFromApiLoginPost");

                  if (rememberMe == true) {
                    await SharedPreferencesHelper.setString(
                        key: 'email', value: emailAddressRegistrationHospital.text);
                    await SharedPreferencesHelper.setString(
                        key: 'password', value: passwordRegistrationHospital.text);
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
                      builder: (context) => HospitalHomeScreen(goverCode: goverCode,cityCode: cityCode,objectFromRegistration: loginReaspons,userAndTokenFromApiLoginPos:userAndTokenFromApiLoginPost),
                    ));
                  } catch (er) {
                    print(er.toString());
                    showToast(context);
                  }
                } catch (er) {
                  print(er.toString());
                  showToast(context);

                }
              } catch (e) {
                print('from catch :  ${e}');
                showToast(context);

              }
            }
          },
          child: Text(
            'تسجيل',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }}
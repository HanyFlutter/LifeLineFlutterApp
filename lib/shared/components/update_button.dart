import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/layout/home_screen/user_home_screen/user_home_screen.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import 'package:lifeline/shared/constants.dart';

class UpdateButton extends StatefulWidget {
  const UpdateButton({super.key});

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {

  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 2, 88, 5))),
          onPressed: () async {

    Map updateJsonToApi = {
      "firstName": firstNameUpdate.value.text.toString(),
      "lastName": lastNameUpdate.value.text.toString(),
      "birthDate": birthDayUpdate.value.text.toString(),
      "phone": phoneNumberUpdate.value.text.toString(),
      "bloodType": selectedBloodTypeMenu.toString(),
      "gov": goverCode.toString(),
      "city": cityCode.toString(),
      "disease": listOfDiseasesSelectedValue,
      "donationTimes": donationTimes,
      "gender": (selectedGenderItem=="ذكر"?"m":"f"),

    };
    if (userFormKeyUpdate.currentState!.validate()) {
      print('good to here $userToken     $userID');

      if(passwordUpdate.text.isNotEmpty){
       updateJsonToApi.addAll({"password":passwordUpdate!.text.toString()});
     }
    Response response;
    try {

    SharedPreferencesHelper.getString(key: 'userID').then((value) => userID=value).catchError((e)=>print(e.toString()));
    SharedPreferencesHelper.getString(key: 'userToken').then((value) async{
      userToken=value;
      print('good to here $userToken     $userID');

      response =
          await DioHelper.updateData(url: 'user/${userID}', header: {
        "authentication": userToken
      }, data:updateJsonToApi);
      print("from update screen  done to here");

      objectFromApiUpdatePost = response.data;
      print("from update screen  $objectFromApiUpdatePost");
      updateResponse = proccessOfRegistrationReasponse(
          objectFromApiUpdatePost["updated"]);
      constTitle = updateResponse["firstName"];
      showToast(context,msg: "تم تحديث البيانات",color: Colors.green);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => UserHomeScreen(updateResponse,title:constTitle,userAndTokenFromApiLoginPos:userAndTokenFromApiLoginPost!),
      ));
    }).catchError((e)=>                showToast(context)
    );

    } catch (e) {
    print('from catch :  ${e}');
    showToast(context);


    }
    }

          },
          child: Text(
            'تحديث البيانات',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
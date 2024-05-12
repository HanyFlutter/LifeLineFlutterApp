import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/profile_screen/profile_update.dart';
import 'package:lifeline/modules/login_screen/login_screen.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/shared/components/log_out.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    print('from profile gover code  ${goverCode}');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (ctx){
  return         ProfileUpdate(toControllers:toControllers);

}));
      },child: Text('تعديل',style: TextStyle(color: Colors.white),),),
        body: Center(
            child: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          CircleAvatar(
              radius: 60,
              backgroundColor:
              selectedGenderItem == 'ذكر' ? Colors.blue : Colors.pink,
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.white,
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Card(
                child: Text(
                  "الإسم :  ${toControllers!["firstName"]}  ${toControllers!["lastName"]}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                child: Text(
                  "تاريخ الميلاد  :${toControllers!["birthDate"]}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Text(
                  " النوع : ${toControllers!["gender"]} ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Text(
                  "${toControllers!["bloodType"]} فصيلة الدم : ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Text(
                  "المحافظة  : ${toControllers!["gov"]}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Text(
                  "المدينة  :  ${toControllers!["city"]} ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                child: Text(
                  ' عدد مرات التبرع   :  ${toControllers!["donationTimes"]} ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                child: Text(
                  '  ${toControllers!["email"]} :البريد الإلكتروني ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                child: Text(
                  "رقم الموبايل : ${toControllers!["phone"]}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              (toControllers!["disease"]).length == 0
                  ? Container()
                  : Center(
                      child: Card(
                        child: Column(
                          children: [
                            Text(
                              ": الأمراض",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Card(
                                child: Center(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: (toControllers!["disease"]).length,
                                  itemBuilder: (ctx, index) {
                                    return Card(
                                      child: Center(
                                        child: Text(
                                          toControllers!["disease"][index],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    );
                                  }),
                            ))
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 179, 17, 17))),
                child: Text(
                  'تسجيل خروج',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                
                  await SharedPreferencesHelper.remove();

                  rememberMe = false;
                  email = '';
                  password = '';
                  userType = '';
                  userID='';
                  userToken='';
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              )
            ],
          ),
        ],
      ),
    )));
  }
}

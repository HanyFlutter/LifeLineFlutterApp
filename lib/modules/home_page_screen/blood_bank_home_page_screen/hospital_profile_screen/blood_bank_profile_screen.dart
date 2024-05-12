import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lifeline/modules/login_screen/login_screen.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';

import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/constants.dart';

class BloodBankProfileScreen extends StatefulWidget {
  const BloodBankProfileScreen({super.key});

  @override
  State<BloodBankProfileScreen> createState() => _BloodBankProfileScreenState();
}

class _BloodBankProfileScreenState extends State<BloodBankProfileScreen> {

  @override
  Widget build(BuildContext context) {
    print('blood drive  ${objectFromHospitalRegistration["bloodGroup"][0]["bloodType"]}');

    return Scaffold(

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
               Colors.blue ,
              child: Center(
                child: Icon(
                  Icons.home_work,
                  size: 100,
                  color: Colors.white,
                ),
              )),
        Card(child:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            SizedBox(height: 20,),
            Card(child: Text(' ${objectFromHospitalRegistration["name"]}',style: TextStyle(fontSize: 18),),)
            ,SizedBox(height: 15,),
            Card(child: Text(' ${objectFromHospitalRegistration["email"]}: البريد الالكتروني    ',style: TextStyle(fontSize: 16),),)
            ,SizedBox(height: 15,),
            Card(child: Text('رقم الهاتف  : ${hospitalsMap["$goverCode"]![cityIndex][6]}',style: TextStyle(fontSize: 18),),)
            ,SizedBox(height: 15,),
            Card(child: Text('المحافظة  : ${objectFromHospitalRegistration["gov"]}',style: TextStyle(fontSize: 18),),)
            ,SizedBox(height: 15,),
            Card(child: Text('المدينة  : ${objectFromHospitalRegistration["city"]}',style: TextStyle(fontSize: 18),),)
            ,SizedBox(height: 15,),
            Card(child: Text('العنوان  : ${objectFromHospitalRegistration["addressDescription"]}',style: TextStyle(fontSize: 18),),),
            SizedBox(height: 15,),
Card(child: Text('أكياس الدم المتاحة وعددها',style: TextStyle(fontSize: 20),),),
            SizedBox(height: 15,),

Card(child:ListView.builder(
  physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: objectFromHospitalRegistration["bloodGroup"].length,
    itemBuilder: (context,index){
return      Card(child:
    Padding(padding: EdgeInsets.all(10),child:
    Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(leading: CircleAvatar(child: Text(objectFromHospitalRegistration["bloodGroup"][index]["bloodType"],style: TextStyle(fontSize: 20),),),title: Text("  عدد الاكياس  ${objectFromHospitalRegistration["bloodGroup"][index]["count"].toString()}",style: TextStyle(fontSize: 18),),),),

    )
);
    }) ,)
          ],
        ),),
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
    )));
  }
}

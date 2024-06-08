import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/login_button.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_date_picker.dart';
import 'package:lifeline/shared/const_hospital_details.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:lifeline/styles/main_style.dart';

class BloodBankArgentCall extends StatefulWidget {
  const BloodBankArgentCall({super.key});

  @override
  State<BloodBankArgentCall> createState() => _BloodBankArgentCallState();
}

class _BloodBankArgentCallState extends State<BloodBankArgentCall> {
  void initState(){
    super.initState();
    try{
      DioHelper.getDataWithoutBody(url: 'argentCall', header: {
        "authentication": userAndTokenFromApiLoginPost!["token"]
      },param: {"bloodBankID":userAndTokenFromApiLoginPost!["bloodBankID"]}).then((val){print ('from argentCall ${val.data}');
      setState(() {
        argentCall=val.data;
      });
      ;});
      print("from argentCall screen  done to here");

    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            SizedBox(
              height: 5,
            ),
        
            Text(
              'الاستغاثات النشطة ',
              style: TextStyle(fontSize: 20.0, color: mainColor),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx,index){
              return Card(child: Column(children: [
                Text('إسم المستشفى:  ${argentCall[index]["hospital"]["name"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
                Text('وصف الاستغاثة:  ${argentCall[index]["description"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
                Text('تاريخ بدء الإستغاثة:  ${argentCall[index]["createDate"].toString().split('T')[0]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),

                Text('هاتف المستشفى :  ${argentCall[index]["hospital"]["phone"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),

                SizedBox(
                  height: 5,
                ),
                Text(' عنوان المستشفى:  ${argentCall[index]["hospital"]["addressDescription"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemBuilder: (cctx,ind){

  return Row(children: [
    CircleAvatar(
        radius: 28
       , child: Text(' ${argentCall[index]['bloodGroup'][ind]['bloodType']}',style: TextStyle(fontSize: 19),)),
    SizedBox(
      width: 5,
    ),
    Text('عدد الاكياس المطلوب : ${argentCall[index]['bloodGroup'][ind]['count'].toString()}',style: TextStyle(fontSize: 18),),

  ],);
},itemCount:argentCall[index]['bloodGroup'].length ,),
              ],),);
            },itemCount: argentCall.length,)
        
          ],),
      ),
    );
  }
}

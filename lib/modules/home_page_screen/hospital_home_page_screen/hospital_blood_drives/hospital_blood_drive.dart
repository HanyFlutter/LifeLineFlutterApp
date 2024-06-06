import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:lifeline/styles/main_style.dart';

class HospitalBloodDrive extends StatefulWidget {
  const HospitalBloodDrive({super.key});

  @override
  State<HospitalBloodDrive> createState() => _HospitalBloodDriveState();
}

class _HospitalBloodDriveState extends State<HospitalBloodDrive> {
  void initState(){
    super.initState();
    try{
      DioHelper.getDataWithoutBody(url: 'bloodDrive', header: {
        "authentication": userAndTokenFromApiLoginPost!["token"]
      },param: {"hospitalID":userAndTokenFromApiLoginPost!["hospitalID"]}).then((val){print ('from bloodDrive ${val.data}');
      setState(() {
        bloodDrives=val.data;
      });
      ;});
      print("from bloodDrive screen  done to here");

    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(child:
    Column(children: [    SizedBox(
      height: 5,
    ),

      Text(
        'الحملات المتاحة ',
        style: TextStyle(fontSize: 20.0, color: mainColor),
      ),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: ListView.builder(itemBuilder: (ctx,index){
          return Card(child: Column(children: [
            Text('إسم بنك الدم:  ${bloodDrives[index]["bloodBank"]["name"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
            SizedBox(
              height: 5,
            ),
            Text('وصف الحملة:  ${bloodDrives[index]["description"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
            SizedBox(
              height: 5,
            ),
            Text('تاريخ بدء الحملة:  ${bloodDrives[index]["startDate"].toString().split('T')[0]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
            SizedBox(
              height: 5,
            ),
            Text('تاريخ انتهاء الحملة:  ${bloodDrives[index]["endDate"].toString().split('T')[0]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
            SizedBox(
              height: 5,
            ),
            Text('هاتف بنك الدم :  ${bloodDrives[index]["bloodBank"]["phone"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),

            SizedBox(
              height: 5,
            ),
            Text(' عنوان بنك الدم:  ${bloodDrives[index]["bloodBank"]["addressDescription"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
            SizedBox(
              height: 5,
            ),

          ],),);
        },itemCount: bloodDrives.length,),
      )],),);
  }
}

import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/constants.dart';

class UserBloodDrive extends StatefulWidget {
  const UserBloodDrive({super.key});

  @override
  State<UserBloodDrive> createState() => _UserBloodDriveState();
}

class _UserBloodDriveState extends State<UserBloodDrive> {
  void initState(){
    super.initState();
    try{
      DioHelper.getDataWithoutBody(url: 'bloodDrive', header: {
        "authentication": userToken
      },param: {"userID":userID}).then((val){print ('from bloodDrive ${val.data}');
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
    return ListView.builder(itemBuilder: (ctx,index){
      return Card(child: Column(children: [Text(bloodDrives.toString())],),);
    },itemCount: bloodDrives.length,);
  }
}

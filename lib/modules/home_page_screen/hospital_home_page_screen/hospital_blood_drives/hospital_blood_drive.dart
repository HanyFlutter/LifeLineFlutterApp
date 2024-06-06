import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/constants.dart';

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
    return ListView.builder(itemBuilder: (ctx,index){
      return Card(child: Column(children: [Text(bloodDrives.toString())],),);
    },itemCount: bloodDrives.length,);
  }
}

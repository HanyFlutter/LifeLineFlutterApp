import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_hospital.dart';
import 'package:lifeline/shared/constants.dart';

class HospitalUpdateButton extends StatefulWidget {
  const HospitalUpdateButton({super.key});

  @override
  State<HospitalUpdateButton> createState() => _HospitalUpdateButtonState();
}

class _HospitalUpdateButtonState extends State<HospitalUpdateButton> {

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
            objectBloodGroupWithoutID=[];
            for (var item in objectFromHospitalRegistration["bloodGroup"]) {
              Map<String, dynamic> newItem = Map.from(item);
              newItem.remove('_id');
              objectBloodGroupWithoutID.add(newItem);
            }
            print('good to here $objectBloodGroupWithoutID');

            Response response;
            try {
              await DioHelper.updateData(url: 'hospital/${userAndTokenFromApiLoginPost!["hospitalID"]}', header: {
                "authentication": userAndTokenFromApiLoginPost!["token"]
              }, data:{
                "bloodGroup": updatingBloodGroups["bloodGroup"]
              }).then((value)  {
print('updating object $updatingBloodGroups');
                showToast(context,msg: "تم تحديث البيانات",color: Colors.green);

              });

            } catch (e) {
              showToast(context);
              print('from catch :  ${e}');

            }},


          child: Text(
            'تحديث البيانات',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
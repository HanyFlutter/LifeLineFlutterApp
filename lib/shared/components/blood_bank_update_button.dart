import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_hospital.dart';
import 'package:lifeline/shared/constants.dart';

class BloodBankUpdateButton extends StatefulWidget {
  const BloodBankUpdateButton({super.key});

  @override
  State<BloodBankUpdateButton> createState() => _BloodBankUpdateButtonState();
}

class _BloodBankUpdateButtonState extends State<BloodBankUpdateButton> {

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
            print('good to here $userAndTokenFromApiLoginPost!["token"]');

              Response response;
              try {
                await DioHelper.updateData(url: 'bloodBank/${userAndTokenFromApiLoginPost!["bloodBankID"]}', header: {
                  "authentication": userAndTokenFromApiLoginPost!["token"]
                }, data:{
                  "bloodGroup":objectBloodGroupWithoutID
                }).then((value)  {
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
import 'package:flutter/material.dart';
import 'package:lifeline/shared/const_validation.dart';
import 'package:lifeline/shared/constants.dart';


Widget phoneNumberText({required TextEditingController controller,}){
  return Container(
    height: 70,
    child: TextFormField(

      decoration: InputDecoration(

        prefix: Icon(Icons.phone_android),
        suffix: Text('EG +2'),
        labelText: 'رقم الهاتف ',
        labelStyle:   TextStyle(),
        border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(20)),
      ),
      controller: controller,
      keyboardType: TextInputType.number,
      validator: ( val){
        if(val!.isEmpty){
          return 'حقل رقم الهاتف فارغ ' ;
        }
        if(!validateEgyptianPhoneNumber(val)){
          return 'الرقم الذي أدخلته ليس رقم هاتف محمول مصري';
        }
        return null ;
      },
    ),
  );
}
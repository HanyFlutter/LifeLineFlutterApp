import 'package:flutter/material.dart';
import 'package:lifeline/shared/const_validation.dart';
import 'package:lifeline/shared/constants.dart';


Widget passwordRegistrationText({required TextEditingController controller,required bool showPassword, required Function toggel,required String labelText, required TextEditingController? controller2}){

  return Container(
    height: 70,
    child: TextFormField(

      controller: controller,
      obscureText: showPassword,
      keyboardType: TextInputType.text,
      validator: (val){
        if(val!.isEmpty)
        {return 'حقل كلمة المرور فارغ';}
        if(!validatePassword(val)){
          return "كلمة المرور غير صحيحة";
        }
        if(controller.text!=controller2?.text){
          return "كلمة المرور غير متطابقة";
        }

        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffix:  IconButton(onPressed:()=> toggel(), icon: showPassword? Icon(Icons.visibility):Icon(Icons.visibility_off)),
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    ),
  );
}
Widget passwordLoginText({required TextEditingController controller,required bool showPassword, required Function toggel,required String labelText}){

  return Container(
    height: 70,
    child: TextFormField(

      controller: controller,
      obscureText: showPassword,
      keyboardType: TextInputType.text,
      validator: (val){
        if(val!.isEmpty)
        {return 'حقل كلمة المرور فارغ';}
        if(!validatePassword(val)){
          return "كلمة المرور غير صحيحة";
        }


        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffix:  IconButton(onPressed:()=> toggel(), icon: showPassword? Icon(Icons.visibility):Icon(Icons.visibility_off)),
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    ),
  );
}
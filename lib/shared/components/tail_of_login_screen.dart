import 'package:flutter/material.dart';
import 'package:lifeline/modules/policy_screen/policy_screen.dart';

import '../../modules/registration_screen/registration_screen.dart';
class tailOfLoginScreen extends StatelessWidget {
  const tailOfLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(textWidthBasis: TextWidthBasis.parent,'ليس لديك حساب ؟ '),
            TextButton(onPressed: (){

              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>RegisterScreen()));
            }, child: Text('تسجيل حساب جديد')),
          ],),
        TextButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (vtx)=>PolicyScreen()));
        }, child: Text('سياسة الإستخدام والخصوصية')),
      ],
    );
  }
}


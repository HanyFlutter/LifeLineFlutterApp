import 'package:flutter/material.dart';

void showToast(context,{String? msg,String? buttonLable,Color? color}) {
   showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          color: color??Colors.redAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 Text(msg??'بيانات غير صحيحة ',style: TextStyle(fontSize: 20,color: Colors.white),),
                SizedBox(height: 20,),
                ElevatedButton(
                  child:  Text(buttonLable??'تم',style: TextStyle(fontSize: 18),),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );


}

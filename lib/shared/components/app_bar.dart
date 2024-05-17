
import 'package:flutter/material.dart';
import 'package:lifeline/styles/main_style.dart';

PreferredSizeWidget appBarWidget({required String title}){

  return AppBar(

    backgroundColor:mainColor,

    title: Center(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.monitor_heart,color: Colors.white,),
        SizedBox(width: 5,),
        Text(title,style: TextStyle(fontSize: 16,color: Colors.white),),

      ],
    )),
  );
}
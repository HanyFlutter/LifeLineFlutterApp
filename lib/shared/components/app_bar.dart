
import 'package:flutter/material.dart';

PreferredSizeWidget appBarWidget({required String title}){

  return AppBar(

    backgroundColor:Color.fromARGB(255, 179, 17, 17),

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
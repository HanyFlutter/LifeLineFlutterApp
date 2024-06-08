
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:lifeline/styles/main_style.dart';

class HeroesScreen extends StatefulWidget {
  const HeroesScreen({super.key});

  @override
  State<HeroesScreen> createState() => _HeroesScreenState();
}

class _HeroesScreenState extends State<HeroesScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {

      DioHelper.getDataWithoutBody(url: 'user/Heros', header: {
        "authentication": userToken,
        "Content-Type":"application/json"
      }
      ).then((value){
        setState(() {
          heros=value.data;
        });

      }).catchError((err){print(err.toString());})

      ;}catch(e){print(e.toString());};

          }
  @override
  Widget build(BuildContext context) {
    return Center(child:
    Column(

      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 10,),

        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: [
              Icon(Icons.wine_bar,color: Colors.orangeAccent,size: 50,),
              Text('قائمة الأبطال الأكثر تبرعاً',style: TextStyle(fontSize: 25,color: mainColor),),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(itemBuilder: (ctx,index){
            return Card(
              color: Colors.blue
            ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wine_bar,color: Colors.yellowAccent,size: 30,),

                    Text('اسم البطل ${heros[index]["fullName"]}',style: TextStyle(fontSize: 22,color: Colors.white),),
                  ],
                ),
                  SizedBox(height: 5,),
                  Text('الترتبيب ${heros[index]["rank"]}',style: TextStyle(fontSize: 18,color:  Colors.yellowAccent),),
                  SizedBox(height: 5,),
                  Text('الهاتف ${heros[index]["phone"]}',style: TextStyle(fontSize: 18,color:  Colors.yellowAccent),),
                  SizedBox(height: 5,),
                  Text('عدد مرات التبرع ${heros[index]["donationTimes"]}',style: TextStyle(fontSize: 18,color: Colors.yellowAccent),),
                  SizedBox(height: 5,),
              ],),
            );
          },itemCount: 20>heros.length?heros.length:20,),
        ),
      ],
    )
      ,);
  }
}

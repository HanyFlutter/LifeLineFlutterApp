import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:lifeline/styles/main_style.dart';

class BloodBankOrdersList extends StatefulWidget {
  const BloodBankOrdersList({super.key});

  @override
  State<BloodBankOrdersList> createState() => _BloodBankOrdersListState();
}

class _BloodBankOrdersListState extends State<BloodBankOrdersList> {
  void initState(){
    super.initState();
    try{
      DioHelper.getDataWithoutBody(url: 'order/ordersList', header: {
        "authentication": userAndTokenFromApiLoginPost!["token"]
      },param: {"bloodBankID":userAndTokenFromApiLoginPost!["bloodBankID"]}).then((val){print ('from bloodDrive ${val.data}');
      setState(() {
        orderListFromApi=val.data;
      });
      ;});
      print("from bloodDrive screen  done to here");

    }catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: ListView.builder(itemBuilder: (ctx,index){
          return Card(child: Column(children: [
            SizedBox(
              height: 5,
            ),
            Text('إسم المستشفى :  ${orderListFromApi[index]["hospital"]["name"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
            SizedBox(
              height: 5,
            ),
            Text('تاريخ بدء الطلب:  ${orderListFromApi[index]["createdAt"].toString().split('T')[0]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
            SizedBox(
              height: 5,
            ),

            Text('هاتف المستشفى :  ${orderListFromApi[index]["hospital"]["phone"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),

            SizedBox(
              height: 5,
            ),
            Text(' عنوان  المستئفى :  ${orderListFromApi[index]["hospital"]["addressDescription"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
            SizedBox(
              height: 5,
            ),

          ],),);


    ],)


      ,);
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
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
    return Directionality(
      textDirection:  TextDirection.rtl,

      child: Center(child: Column(children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(itemBuilder: (ctx,index){
      return Card(child: Column(children: [
        Text(' حالة الطلب : ${orderListFromApi[index]['status']=="pending"?"قيد الإنتظار":orderListFromApi[index]['status']=="reject"?"مرفوض ":"مقبول "}  ', style: TextStyle(fontSize: 17.0, color: mainColor)),

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
        orderListFromApi[index]["from"]== "bank"&&orderListFromApi[index]["to"]== "hospital" ?
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 2, 88, 5))),
                  onPressed: () async{
                    Response response;
                    try {
                      response = await DioHelper.updateData(
                          url: 'order/changeStatus', data: {
                        "status":"approved"
                      },header: {"authentication":userAndTokenFromApiLoginPost!["token"]},param: {"bloodBankID":userAndTokenFromApiLoginPost!["bloodBankID"],"orderID":orderListFromApi[index]["orderID"]});
                      print('from approved ${response.data}');
                    } catch (e) {
                      showToast(context);
                      print('from approved :  ${e}');
                    }



                  },
                  child: Text(
                    'قبول الطلب ',
                    style: TextStyle(color: Colors.white),
                  )),
            ),

            SizedBox(
              width: 20,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 179, 17, 17))),
                  onPressed: () async{
                    Response response;
                    try {
                      response = await DioHelper.updateData(
                          url: 'order/changeStatus', data: {
                        "status":"reject"

                      },header: {"authentication":userAndTokenFromApiLoginPost!["token"]},param: {"bloodBankID":userAndTokenFromApiLoginPost!["bloodBankID"],"orderID":orderListFromApi[index]["orderID"]});
                      showToast(context,msg: "تم تحديث البيانات",color: Colors.green);

                      print('from reject ${response.data}');
                    } catch (e) {
                      showToast(context);
                      print('from reject :  ${e}');
                    }
                  },
                  child: Text(
                    'رفض الطلب ',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ):Container(),
      ],),);

      },itemCount: orderListFromApi.length,),)
      ],)


        ,),
    );
  }
}

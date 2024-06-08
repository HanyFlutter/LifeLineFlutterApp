import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:lifeline/styles/main_style.dart';

class HospitalOrdersList extends StatefulWidget {
  const HospitalOrdersList({super.key});

  @override
  State<HospitalOrdersList> createState() => _HospitalOrdersListState();
}

class _HospitalOrdersListState extends State<HospitalOrdersList> {
  void initState(){
    super.initState();
    try{
      DioHelper.getDataWithoutBody(url: 'order/ordersList', header: {
        "authentication": userAndTokenFromApiLoginPost!["token"]
      },param: {"hospitalID":userAndTokenFromApiLoginPost!["hospitalID"]}).then((val){print ('from bloodDrive ${val.data}');
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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(Icons.list_alt,color: Colors.orangeAccent,size: 25,),
          Text('الطلبات بين بنك الدم والمستشفى',style: TextStyle(fontSize: 18,color: mainColor),),
        ],
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
            orderListFromApi[index]["from"]== "hospital"&&orderListFromApi[index]["to"]== "bank" ?
            Row(
              children: [
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

                          },header: {"authentication":userAndTokenFromApiLoginPost!["token"]},param: {"hospitalID":userAndTokenFromApiLoginPost!["hospitalID"],"orderID":orderListFromApi[index]["orderID"]});
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
                SizedBox(
                  width: 20,
                ),
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
                          },header: {"authentication":userAndTokenFromApiLoginPost!["token"]},param: {"hospitalID":userAndTokenFromApiLoginPost!["hospitalID"],"orderID":orderListFromApi[index]["orderID"]});
                          showToast(context,msg: "تم تحديث البيانات",color: Colors.green);

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
              ],
            ):Container(),

          ],),);
        },itemCount: orderListFromApi.length,),
      ),


    ],)


      ,);
  }
}

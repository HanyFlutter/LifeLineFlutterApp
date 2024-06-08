import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_hospital_details.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:lifeline/styles/main_style.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class SelectedBloodTypeHospital extends StatefulWidget {
  const SelectedBloodTypeHospital({super.key,required  this.bloodGroupList,required this.userAndToken});
final bloodGroupList;
final userAndToken;
  @override
  State<SelectedBloodTypeHospital> createState() => _SelectedBloodTypeHospitalState();
}

class _SelectedBloodTypeHospitalState extends State<SelectedBloodTypeHospital> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    bloodGroup=widget.bloodGroupList['bloodGroup'];
    userAndTokenFromApiLoginPost=widget.userAndToken;
    return Scaffold(
        key: this._scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 600,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [

                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Expanded(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),

                          itemCount: bloodGroup.length,
                          itemBuilder: (ctx,index){
                            return Center(child:Column(children: [
                              Row(mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Card(child: Text('${bloodGroup[index]['bloodType']}',style: TextStyle(fontSize: 18),)),
                                  Text('عدد أكياس الدم المتاح :${bloodGroup[index]['count']}',style: TextStyle(fontSize: 18),),
                                  ElevatedButton(onPressed: (){
                                    setState(() {
                                      (bloodGroup[index]['count'])>0? bloodGroup[index]['count']--: bloodGroup[index]['count']=0;

                                    });
                                  }
                                    ,child: Text('-',style: TextStyle(fontSize: 25),),),


                                  Center(
                                    child: ElevatedButton(

                                      onPressed: (){
                                      setState(() {
                                        bloodGroup.removeAt(index);

                                      });
                                    }
                                      ,child: Icon(size: 20,Icons.delete_forever),),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            ],));
                          }),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 179, 17, 17))),
                            onPressed: () {
                              Navigator.pop(context, []);

                            },
                            child: Text(
                              'الغاء ',
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
                              print('bloodBank id is : ${widget.bloodGroupList['_id']}');
                              bloodGroup.forEach((a){a.remove('_id');});
                              print('after remove id $bloodGroup');
                              Response response;
    try {
    response = await DioHelper.postData(url: 'order/Add', data: {
      "bloodGroup":bloodGroup,
      "bloodBankID": widget.bloodGroupList["_id"],
      "hospitalID": userAndTokenFromApiLoginPost!["hospitalID"],
      "from": "bank",
      "to": "hospital"

    },header: {"authentication":userAndTokenFromApiLoginPost!["token"]},param: {"hospitalID":userAndTokenFromApiLoginPost!["hospitalID"]});
print(response.data);
    showToast(context,msg: "تم تحديث البيانات",color: Colors.green);

    } catch (e) {
    showToast(context);
    print('from catch :  ${e}');
    }


                              Navigator.pop(context, []);

                            },
                            child: Text(
                              'إنشاء طلب ',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

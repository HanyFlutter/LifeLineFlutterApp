import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/login_button.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_date_picker.dart';
import 'package:lifeline/shared/const_hospital_details.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:lifeline/styles/main_style.dart';

class HospitalArgentCall extends StatefulWidget {
  const HospitalArgentCall({super.key});

  @override
  State<HospitalArgentCall> createState() => _HospitalArgentCallState();
}

class _HospitalArgentCallState extends State<HospitalArgentCall> {
  Widget createArgentCallButton(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 2, 88, 5))),
          onPressed: () async {
            Map createArgentCallJsonToApi ;
            if (createArgentCallFormKey.currentState!.validate()) {

              createArgentCallJsonToApi = {
                "createDate": argentCallStart.value.text.toString(),
                "bloodGroup":bloodGroup,
                "gov": goverCode,
                "city": hospitalsMap["$goverCode"]![cityIndex][3],
                "description": argentCallDescription.value.text.toString(),
            "hospitalID": userAndTokenFromApiLoginPost!["hospitalID"],


            };
              print('object of api bloodDrive ${createArgentCallJsonToApi}');
              Response response;
              try {
                response = await DioHelper.postData(
                    url: 'argentCall/Add', data: createArgentCallJsonToApi,header: {"authentication":userAndTokenFromApiLoginPost!["token"]});
                print('object create call from api ${response.data}');
                showToast(context,msg: "تم تحديث البيانات",color: Colors.green);

              } catch (e) {
                showToast(context);
                print('from catch :  ${e}');
              }
            }},



          child: Text(
            'إنشاء ',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
  void initState(){
    super.initState();
    try{
      DioHelper.getDataWithoutBody(url: 'argentCall', header: {
        "authentication": userAndTokenFromApiLoginPost!["token"]
      },param: {"hospitalID":userAndTokenFromApiLoginPost!["hospitalID"]}).then((val){print ('from argentCall ${val.data}');
      setState(() {
        argentCall=val.data;
      });
      ;});
      print("from argentCall screen  done to here");

    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 10,),
            Card(
              child: Column(

                mainAxisSize: MainAxisSize.max,

                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(Icons.ring_volume_outlined,color: Colors.red,size: 25,),
                    SizedBox(width: 10,),

                    Text('إنشاء إستغاثةً',style: TextStyle(fontSize: 18,color: mainColor),),
                  ],
                ),
                  SizedBox(height: 10,),

                  Form(
                    key: createArgentCallFormKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          Container(
                              width: double.infinity,
                              child:TextFormField(
                                controller: argentCallDescription,
                                decoration: InputDecoration(
                                    labelText: 'وصف الاستغاثة ',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20))),
                              )
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: argentCallStart,

                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return 'خانة تاريخ بداية الإستغاثة مطلوبة ';
                              }
                            },
                            onTap: () {
                              showDatePickerStartArgent(context);
                            },
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: 'تاريخ بداية الاستغاثة',
                              border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx,theIndex){
                            return Row(children: [
                              CircleAvatar(child: Text(bloodGroup[theIndex]['bloodType'],style: TextStyle(fontSize: 20),)),
                              SizedBox(width: 10,),
                              ElevatedButton(onPressed: (){setState(() {
                                bloodGroup[theIndex]['count']++;
                              });}, child: Text('+',style: TextStyle(fontSize: 20),)),
                              SizedBox(width: 10,),

                              Text(bloodGroup[theIndex]['count'].toString(),style: TextStyle(fontSize: 20),),
                              SizedBox(width: 10,),

                              ElevatedButton(onPressed: (){setState(() {
                                bloodGroup[theIndex]['count']>0?     bloodGroup[theIndex]['count']--:bloodGroup[theIndex]['count']=0;
                              });}, child: Text('-',style: TextStyle(fontSize: 20),)),
                            ],);
                          },itemCount: bloodGroup.length,),

                          createArgentCallButton(context),

                        ]

                    )),

              ],),
            ),
        
        
        
            SizedBox(
              height: 5,
            ),
        
            Text(
              'الاستغاثات النشطة ',
              style: TextStyle(fontSize: 20.0, color: mainColor),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx,index){
              return Card(child: Column(children: [
                Text('إسم المستشفى:  ${argentCall[index]["hospital"]["name"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
                Text('وصف الاستغاثة:  ${argentCall[index]["description"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
                Text('تاريخ بدء الإستغاثة:  ${argentCall[index]["createDate"].toString().split('T')[0]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),

                Text('هاتف المستشفى :  ${argentCall[index]["hospital"]["phone"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),

                SizedBox(
                  height: 5,
                ),
                Text(' عنوان المستشفى:  ${argentCall[index]["hospital"]["addressDescription"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemBuilder: (cctx,ind){

  return Row(children: [
    CircleAvatar(
        radius: 28
       , child: Text(' ${argentCall[index]['bloodGroup'][ind]['bloodType']}',style: TextStyle(fontSize: 19),)),
    SizedBox(
      width: 5,
    ),
    Text('عدد الاكياس المطلوب : ${argentCall[index]['bloodGroup'][ind]['count'].toString()}',style: TextStyle(fontSize: 18),),

  ],);
},itemCount:argentCall[index]['bloodGroup'].length ,),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 179, 17, 17))),
                    onPressed: (){


                  try {

                    DioHelper.deleteData(url: 'argentCall/${argentCall[index]['ArgentCallID']}', header: {
                      "authentication": userAndTokenFromApiLoginPost!['token'],
                    }
                    ).then((value){
                      showToast(context,msg: "تم تحديث البيانات",color: Colors.green);

                    }).catchError((err){

                      print(err.toString());})

                    ;}catch(e){
                    showToast(context);

                    print(e.toString());};
                }, child: Text('حذف الإستغاثة',style: TextStyle(fontSize: 17,color: Colors.white),))
              ],),);
            },itemCount: argentCall.length,)
        
          ],),
      ),
    );
  }
}

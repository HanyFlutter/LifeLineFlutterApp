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

class BloodBankBloodDrive extends StatefulWidget {
  const BloodBankBloodDrive({super.key});

  @override
  State<BloodBankBloodDrive> createState() => _BloodBankBloodDriveState();
}

class _BloodBankBloodDriveState extends State<BloodBankBloodDrive> {
  Widget createBloodDriveButton(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 2, 88, 5))),
          onPressed: () async {
            Map createBloodDriveJsonToApi ;
            if (createBloodDriveFormKey.currentState!.validate()) {

              createBloodDriveJsonToApi = {
                "startDate": bloodDriveStart.value.text.toString(),
                "endDate": bloodDriveEnd.value.text.toString(),
                "phone": hospitalsMap["$goverCode"]![cityIndex][6],
                "description": bloodDriveDescription.value.text.toString(),
                "bloodBankID": userAndTokenFromApiLoginPost!["bloodBankID"],

              };
              print('object ot api bloodDrive ${createBloodDriveJsonToApi}');
              Response response;
              try {
                response = await DioHelper.postData(
                    url: 'bloodDrive/Add', data: createBloodDriveJsonToApi,header: {"authentication":userAndTokenFromApiLoginPost!["token"]});

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
      DioHelper.getDataWithoutBody(url: 'bloodDrive', header: {
        "authentication": userAndTokenFromApiLoginPost!["token"]
      },param: {"bloodBankID":userAndTokenFromApiLoginPost!["bloodBankID"]}).then((val){print ('from bloodDrive ${val.data}');
      setState(() {
        bloodDrives=val.data;
      });
      ;});
      print("from bloodDrive screen  done to here");

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
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
            
                children: [
                  Icon(Icons.minor_crash_sharp,color: Colors.orangeAccent,size: 25,),
                  Text('إنشاء حملة تبرع بالدمً',style: TextStyle(fontSize: 18,color: mainColor),),
                ],
              ),
              Form(
                  key: createBloodDriveFormKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                      
                        Container(
                            width: double.infinity,
                            child:TextFormField(
                              controller: bloodDriveDescription,
                              decoration: InputDecoration(
                                  labelText: 'وصف الحملة ',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            )
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: bloodDriveStart,
                      
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'خانة تاريخ بداية الحملة مطلوبة ';
                            }
                          },
                          onTap: () {
                            showDatePickerStart(context);
                          },
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: 'تاريخ بداية الحملة',
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        SizedBox(height: 10,),

                        TextFormField(
                          controller: bloodDriveEnd,
                      
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'خانة تاريخ نهاية الحملة مطلوبة ';
                            }
                          },
                          onTap: () {
                            showDatePickerEnd(context);
                          },
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: 'تاريخ نهاية الحملة',
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      
                        createBloodDriveButton(context),
                      
                      ]
                      
                  )),
                      
            ],),
          ),
            SizedBox(
              height: 5,
            ),
            Text(
              'الحملات النشطة ',
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
                 Divider(
                          height: 30,
                          color: Colors.red,
                          thickness: 5,
                        ),
                Text('إسم بنك الدم:  ${bloodDrives[index]["bloodBank"]["name"]}', style: TextStyle(fontSize: 17.0, color: mainColor)),
                SizedBox(
                  height: 5,
                ),
                Text('وصف الحملة:  ${bloodDrives[index]["description"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
                Text('تاريخ بدء الحملة:  ${bloodDrives[index]["startDate"].toString().split('T')[0]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
                Text('تاريخ انتهاء الحملة:  ${bloodDrives[index]["endDate"].toString().split('T')[0]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
                Text('هاتف بنك الدم :  ${bloodDrives[index]["bloodBank"]["phone"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
            
                SizedBox(
                  height: 5,
                ),
                Text(' عنوان بنك الدم:  ${bloodDrives[index]["bloodBank"]["addressDescription"]}', style: TextStyle(fontSize: 17.0, color: secondColor)),
                SizedBox(
                  height: 5,
                ),
            
              ],),);
            },itemCount: bloodDrives.length,)
        
        ],),
      ),
    );
  }
}

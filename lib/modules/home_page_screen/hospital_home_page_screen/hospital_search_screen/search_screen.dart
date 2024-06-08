import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_orders/selected_blood_type.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_search_screen/selected_blood_type_hospital.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_hospital_details.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:lifeline/styles/main_style.dart';

class HospitalSearchScreen extends StatefulWidget {
  const HospitalSearchScreen({super.key});

  @override
  State<HospitalSearchScreen> createState() => _HospitalSearchScreenState();
}

class _HospitalSearchScreenState extends State<HospitalSearchScreen> {
  void initState(){
  super.initState();
  try{
    DioHelper.getDataWithoutBody(url: 'bloodBank/lists', header: {
      "authentication": userAndTokenFromApiLoginPost!["token"]
    },param: {"hospitalID":userAndTokenFromApiLoginPost!["hospitalID"]}).then((val){print ('from search ${val.data}');
   setState(() {
     hospitalListFromApi=val.data;
   });
    ;});
    print("from search screen  done to here");

  }catch(e){

  }
}
 /* Widget selectGover(){
    return Row(
      children: [
        Card(child:         Text(
          ' إبحث عن مستشفيات في محافظة   ',
          style: TextStyle(fontSize: 14),
        ) ,),
        Center(
          child: DropdownButton<String>(
            value: selectedGoverMenu, // Default value
            onChanged: (String? newValue) {
              setState(() {

                cityIndex = 0;
                selectedGoverMenu = newValue!;
                goverListWithItsCode.forEach(
                        (e) => e[1] == selectedGoverMenu ? goverCode = e[0] : 0);

                selectedHospitalName = hospitalsMap[goverCode]![0][4];
                selectedCity = hospitalsMap[goverCode]![0][2];

                print('gover code is $goverCode');
              });

              // Handle dropdown item selection
            },
            items: goverListWithItsCode.map((value) {
              return DropdownMenuItem<String>(
                value: value[1],
                child: Text(
                  value[1],
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(textDirection: TextDirection.rtl, child: Padding(padding: EdgeInsets.all(10),child: Center(child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
        SizedBox(height: 10,),

        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: [
              Text('قائمة ببنوك الدم',style: TextStyle(fontSize: 22,color: mainColor),),
            ],
          ),
        ),
        SizedBox(height: 10,),

       /* selectGover(),*/
      SizedBox(height: 10,),
       Expanded(child: ListView.builder(
           itemCount: hospitalListFromApi.length,
           itemBuilder:

           (ctx,index){
         return Card(child: Column(children: [
           Text('اسم بنك الدم ${hospitalListFromApi[index]['name']}',style: TextStyle(fontSize: 18,color: secondColor)),
           SizedBox(height: 5,),
           Text('العنوان ${hospitalListFromApi[index]['addressDescription']}',style: TextStyle(fontSize: 18,color: secondColor)),
           SizedBox(height: 5,),
           Text('البريد الالكتروني ${hospitalListFromApi[index]['email']}',style: TextStyle(fontSize: 16,color: secondColor)),
           SizedBox(height: 5,),
           Text('الهاتف  ${hospitalListFromApi[index]['phone']}' ,style: TextStyle(fontSize: 18,color: secondColor)),
           SizedBox(height: 5,),
           ElevatedButton(
               style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                   Color.fromARGB(255, 2, 88, 5))),
               onPressed: () {
                 setState(()  {
                   print('from create order  ${hospitalListFromApi[index]}');

                try{    showModalBottomSheet(
                       context: context, builder: (context) => SelectedBloodTypeHospital(bloodGroupList:  hospitalListFromApi[index],userAndToken:userAndTokenFromApiLoginPost)).then((value){
                   bloodTypeOrder=value;
                   });}  catch (e) {
                   showToast(context);
                   print('from catch :  ${e}');
                   }

                 });
               },
               child: Text(
                 'طلب أكياس دم ',
                 style: TextStyle(fontSize: 16,color: Colors.white),

               )),

         ],));
       }))
       /* Expanded(
          child: ListView.builder(
              itemCount: hospitalsMap["$goverCode"]!.length,
              itemBuilder: (ctx,index){
                return Card(child: Column(children: [
                  Text('  إسم المدينة  ${hospitalsMap["$goverCode"]![index][2]}'
                      ,style: TextStyle(fontSize: 18,color: mainColor)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('  إسم المستشفى  ${hospitalsMap["$goverCode"]![index][4]}'
                      ,style: TextStyle(fontSize: 18,color: secondColor)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('  العنوان   ${hospitalsMap["$goverCode"]![index][5]}',
                      style: TextStyle(fontSize: 18,color: secondColor)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '  رقم الهاتف :  ${hospitalsMap["$goverCode"]![index][6]} '
                      ,style: TextStyle(fontSize: 18,color: secondColor)),

                  SizedBox(
                    height: 20,
                  ),
                ],),);
              }),
        ),*/
      ],)),))
    );
  }
}

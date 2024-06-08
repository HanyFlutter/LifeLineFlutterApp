import 'package:flutter/material.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_hospital_details.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:lifeline/styles/main_style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void initState() {

    super.initState();
    try{
      DioHelper.getDataWithoutBody(url: 'hospital/lists', header: {
        "authentication": userToken
      },param: {"userID":userID}).then((val){print ('from initState in search ${val.data}');
setState(() {
  hospitalListFromApi=val.data;

});
      ;});
      print("from search screen  done to here");

    }catch(e){

    }

  }
  Widget selectGover(){
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
  }

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
              Text('قائمة المستشفيات وبنوك الدم',style: TextStyle(fontSize: 22,color: mainColor),),
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
           Text('اسم المستشفى ${hospitalListFromApi[index]['name']}',style: TextStyle(fontSize: 18,color: secondColor)),
           SizedBox(height: 5,),
           Text('العنوان ${hospitalListFromApi[index]['addressDescription']}',style: TextStyle(fontSize: 18,color: secondColor)),
           SizedBox(height: 5,),
           Text('البريد الالكتروني ${hospitalListFromApi[index]['email']}',style: TextStyle(fontSize: 16,color: secondColor)),
           SizedBox(height: 5,),
           Text('الهاتف  ${hospitalListFromApi[index]['phone']}' ,style: TextStyle(fontSize: 18,color: secondColor)),
           SizedBox(height: 5,),
           isAllowed? ElevatedButton(onPressed: (){
             try{
             String isHospital="";
             isHospital=  hospitalListFromApi[index]['isOwner']=="hospital"?"hospitalID":"bloodBankID";
               DioHelper.postData(url: 'donate/Add', header: {
                 "authentication": userToken
               },param: {"userID":userID},data: {   "donationDate":'${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',isHospital:hospitalListFromApi[index]['_id']
               }).then((val){print ('from initState in profile ${val.data}');
               isAllowed= val.data=="allowed to donate"? true: false;
               ;});
               print("from profile screen  done to here");
             showToast(context,msg: "تم تحديث البيانات",color: Colors.green);

             }catch(e){
               showToast(context);

             }


           }, child: Text("تبرع",style: TextStyle(color: Colors.white,fontSize: 18),),  style: ButtonStyle(
               backgroundColor:
               MaterialStateProperty.all(Color.fromARGB(255, 2, 88, 5))),):Text('غير متاح التبرع',style: TextStyle(fontSize: 18),)
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

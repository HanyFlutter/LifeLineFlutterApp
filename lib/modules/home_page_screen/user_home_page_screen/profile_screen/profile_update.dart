import 'package:flutter/material.dart';
import 'package:lifeline/shared/components/app_bar.dart';
import 'package:lifeline/shared/components/diseases_select.dart';
import 'package:lifeline/shared/components/login_button.dart';
import 'package:lifeline/shared/components/password_text.dart';
import 'package:lifeline/shared/components/phone_number_text.dart';
import 'package:lifeline/shared/components/select_account_type.dart';
import 'package:lifeline/shared/components/select_city.dart';
import 'package:lifeline/shared/components/select_gover.dart';
import 'package:lifeline/shared/components/update_button.dart';
import 'package:lifeline/shared/const_date_picker.dart';
import 'package:lifeline/shared/const_hospital_details.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import 'package:lifeline/shared/const_validation.dart';
import 'package:lifeline/shared/constants.dart';

class ProfileUpdate extends StatefulWidget {


   ProfileUpdate({super.key,this.toControllers});
final toControllers;


  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {

  Widget selectGover(){
    return Row(
      children: [
        Text(
          ' المحافظة  ',
          style: TextStyle(fontSize: 14),
        ),
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
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     goverListWithItsCode.forEach((element) {

       if(element[1]==toControllers!["gov"]){
        goverCode=element[0];
      }

    });

    phoneNumberUpdate.text=toControllers!["phone"];
    firstNameUpdate.text=toControllers!["firstName"];
    lastNameUpdate.text=toControllers!["lastName"];
    birthDayUpdate.text=toControllers!["birthDate"];
donationTimes=toControllers!["donationTimes"];
        selectedGenderItem=toControllers!["gender"];
    selectedGoverMenu=toControllers!["gov"];
    selectedCity=toControllers!["city"];
print("gover code is $goverCode");
}
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  void toggelEye() {
    setState(() {
      showPasswordRegistration = !showPasswordRegistration;
    });
  }
  bool changePassword=false;
  @override
  Widget build(BuildContext context) {


    return
      Directionality(
        textDirection: TextDirection.rtl,
      child:
      Scaffold(
      appBar: appBarWidget(title: 'تعديل البيانات'),
      body: Center(child:
     Padding(padding: EdgeInsets.all(20),child: SingleChildScrollView(child:
     Form(
       key: userFormKeyUpdate,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const SizedBox(
             height: 10,
           ),
           Container(
             width: double.infinity,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               mainAxisSize: MainAxisSize.max,
               children: [
                 Expanded(
                     child: TextFormField(
                       validator: (String? val) => validateName(val!),
                       controller: firstNameUpdate,
                       decoration: InputDecoration(
                           labelText: 'الاسم الأول',
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20))),
                     )),
                 SizedBox(width: 10),
                 Expanded(
                     child: TextFormField(
                       validator: (String? val) => validateName(val!),
                       controller: lastNameUpdate,
                       decoration: InputDecoration(
                         labelText: 'اللقب',
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20)),
                       ),
                     )),
               ],
             ),
           ),
           SizedBox(
             height: 10,
           ),
           TextFormField(
             validator: (String? val) {
               if (val!.isEmpty) {
                 return 'خانة تاريخ الميلاد مطلوبة ';
               }
             },
             onTap: () {
               showDatePickerFun(context);
             },
             keyboardType: TextInputType.datetime,
             controller: birthDayUpdate,
             decoration: InputDecoration(
               labelText: 'تاريخ الميلاد',
               border:
               OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
             ),
           ),
           SizedBox(
             height: 10,
           ),
           Row(
             children: [
               Expanded(
                 child: Drop(
                   ScreenType: 3,
                 ),
               ),
               Expanded(
                   child: Drop(
                     ScreenType: 4,
                   )),
             ],
           ),
           SizedBox(
             height: 10,
           ),
           selectGover(),
           SizedBox(
             height: 10,
           ),
           SelectCity(),
           ElevatedButton(
               onPressed: () {
                 setState(() async {
                   listOfDiseasesSelectedValue = await showModalBottomSheet(
                       context: context, builder: (context) => DiseasesSelect());
                 });
                 print('قائمة من مودل شيت $listOfDiseasesSelectedValue');
               },
               child: Text(
                 'تحديد الامراض إن وجد',
                 style: TextStyle(fontSize: 16),
               )),
           SizedBox(
             height: 10,
           ),
           Center(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   ' عدد مرات التبرع السابقة',
                   style: TextStyle(fontSize: 16),
                 ),
                 IconButton(
                     onPressed: () {
                       setState(() {
                         donationTimes <= 100 ? donationTimes++ : 0;
                       });
                     },
                     icon: CircleAvatar(child:Icon(Icons.add))),
                 SizedBox(
                   width: 10,
                 ),
                 Text(
                   donationTimes.toString(),
                   style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                 ),
                 SizedBox(
                   width: 10,
                 ),
                 IconButton(
                     onPressed: () {
                       setState(() {
                         donationTimes > 0 ? donationTimes-- : 0;
                       });
                     },
                     icon: CircleAvatar(child: Icon(Icons.remove),)),
                 SizedBox(
                   width: 10,
                 ),
               ],
             ),
           ),
           SizedBox(
             height: 10,
           ),


           phoneNumberText(controller: phoneNumberUpdate),
           SizedBox(
             height: 10,
           ),
           !changePassword? ElevatedButton(
               style: ButtonStyle(
                   backgroundColor:
                   MaterialStateProperty.all(Color.fromARGB(255, 179, 17, 17))),
               onPressed: (){
                 setState(() {

                   changePassword=true;
                 });
               }, child: Text('تغيير كلمة المرور',style: TextStyle(color: Colors.white),)):

           Column(children: [ passwordRegistrationText(
               controller: passwordUpdate,
               controller2: rewritePasswordUpdate,
               showPassword: showPasswordRegistration,
               toggel: toggelEye,
               labelText: 'كلمة المرور'),
             SizedBox(
               height: 20,
             ),
             passwordRegistrationText(
                 controller: rewritePasswordUpdate,
                 controller2: passwordUpdate,
                 showPassword: showPasswordRegistration,
                 toggel: toggelEye,
                 labelText: 'أعد كتابة كلمة المرور'),
             SizedBox(
               height: 10,
             ),
           ],),


           Row(children: [
             Expanded(child:
             UpdateButton(),),
             SizedBox(
               width: 20,
             ),
             Expanded(child:  ElevatedButton(
                 style: ButtonStyle(
                     backgroundColor:
                     MaterialStateProperty.all(Color.fromARGB(255, 179, 17, 17))),
                 onPressed: (){
                   setState(() {
Navigator.pop(context)   ;                });
                 }, child: Text('إلغاء التعديلات',style: TextStyle(color: Colors.white),)),)
           ],)
         ],
       ),
     )),))
    ));
  }
}

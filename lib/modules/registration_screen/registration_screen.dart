import 'package:flutter/material.dart';
import 'package:lifeline/shared/components/diseases_select.dart';
import 'package:lifeline/shared/components/hospital_registration.dart';
import 'package:lifeline/shared/components/login_button.dart';
import 'package:lifeline/shared/components/password_text.dart';
import 'package:lifeline/shared/components/phone_number_text.dart';
import 'package:lifeline/shared/components/select_account_type.dart';
import 'package:lifeline/shared/components/select_city.dart';
import 'package:lifeline/shared//constants.dart';
import 'package:lifeline/shared/components/app_bar.dart';
import 'package:lifeline/shared/const_date_picker.dart';
import 'package:lifeline/shared/const_hospital_details.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import 'package:lifeline/shared/const_validation.dart';

Map registerationOpject = {};

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void toggelEye() {
    setState(() {
      showPasswordRegistration = !showPasswordRegistration;
    });
  }

  Widget SelectAccountType() {
    return Row(
      children: [
        Text(
          ' التسجيل كحساب ',
          style: TextStyle(fontSize: 14),
        ),
        Center(
          child: DropdownButton<String>(
            value: selectedItemJoinAsRegistration, // Default value
            onChanged: (String? newValue) {
              setState(() {
                selectedItemJoinAsRegistration = newValue!;
              });
              // Handle dropdown item selection
              print('Selected: $newValue');
            },
            items: select_list_join_as_in_registration
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  double opacityValue = 0;
  Future timer() async {
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        opacityValue = 1;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarWidget(title: 'تسجيل حساب جديد'),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: AnimatedOpacity(
                  opacity: opacityValue,
                  duration: Duration(seconds: 1),
                  child: Column(
                    children: [
                      SelectAccountType(),
                      selectedItemJoinAsRegistration == 'شخصي'
                          ? userRegistration()
                          : HospitalRegistration()
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

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
  Widget userRegistration(){ return Form(
    key: formKeyUserRegister,
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
                    controller: firstNameRegistration,
                    decoration: InputDecoration(
                        labelText: 'الاسم الأول',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )),
              SizedBox(width: 10),
              Expanded(
                  child: TextFormField(
                    validator: (String? val) => validateName(val!),
                    controller: lastNameRegistration,
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
          controller: birthDayRegistration,
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
                  icon: CircleAvatar(child: Icon(Icons.add),)),
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
        TextFormField(
          validator: (String? val) {
            return validateEmail(val!);
          },
          keyboardType: TextInputType.emailAddress,
          controller: emailAddressRegistration,
          decoration: InputDecoration(
            labelText: 'البريد الإلكتروني',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        phoneNumberText(controller: phoneNumberRegistration),
        SizedBox(
          height: 10,
        ),
        passwordRegistrationText(
            controller: passwordRegistration,
            controller2: rewritePasswordRegistration,
            showPassword: showPasswordRegistration,
            toggel: toggelEye,
            labelText: 'كلمة المرور'),
        SizedBox(
          height: 20,
        ),
        passwordRegistrationText(
            controller: rewritePasswordRegistration,
            controller2: passwordRegistration,
            showPassword: showPasswordRegistration,
            toggel: toggelEye,
            labelText: 'أعد كتابة كلمة المرور'),
        SizedBox(
          height: 10,
        ),
        registerButton(context),
      ],
    ),
  );}
}

import 'package:flutter/material.dart';
import 'package:lifeline/shared/components/hospital_registration_button.dart';
import 'package:lifeline/shared/components/login_button.dart';
import 'package:lifeline/shared/components/password_text.dart';
import 'package:lifeline/shared/components/select_gover.dart';
import 'package:lifeline/shared/components/select_hospital_name.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import 'package:lifeline/shared/const_validation.dart';
import 'package:lifeline/shared/constants.dart';

class HospitalRegistration extends StatefulWidget {
  const HospitalRegistration ({super.key});

  @override
  State<HospitalRegistration > createState() => _HospitalRegistrationState();
}

class _HospitalRegistrationState extends State<HospitalRegistration > {
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
  void toggelEye() {
    setState(() {
      showPasswordRegistration = !showPasswordRegistration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyHospitalRegister,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          selectGover(),
          SizedBox(
            height: 10,
          ),
          SelectHospitalName(),
          SizedBox(
            height: 10,
          ),
          Text('  إسم المدينة  ${hospitalsMap["$goverCode"]![cityIndex][2]}',
              style: TextStyle(fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Text('  إسم المستشفى  ${hospitalsMap["$goverCode"]![cityIndex][4]}',
              style: TextStyle(fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Text('  العنوان   ${hospitalsMap["$goverCode"]![cityIndex][5]}',
              style: TextStyle(fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Text(
            '  رقم الهاتف :  ${hospitalsMap["$goverCode"]![cityIndex][6]} ',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: (String? val) {
              return validateEmail(val!);
            },
            keyboardType: TextInputType.emailAddress,
            controller: emailAddressRegistrationHospital,
            decoration: InputDecoration(
              labelText: 'البريد الإلكتروني',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          passwordRegistrationText(
              controller: passwordRegistrationHospital,
              controller2: rewritePasswordRegistrationHospital,
              showPassword: showPasswordRegistration,
              toggel: toggelEye,
              labelText: 'كلمة المرور'),
          SizedBox(
            height: 20,
          ),
          passwordRegistrationText(
              controller: rewritePasswordRegistrationHospital,
              controller2: passwordRegistrationHospital,
              showPassword: showPasswordRegistration,
              toggel: toggelEye,
              labelText: 'أعد كتابة كلمة المرور'),
          SizedBox(
            height: 10,
          ),
          HospitalRegistrationButton(),
        ],
      ),
    );  }
}

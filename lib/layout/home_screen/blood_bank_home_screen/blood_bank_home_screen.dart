import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_list_of_screens.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_list_of_screens.dart';
import 'package:lifeline/shared/components/app_bar.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/constants.dart';

class BloodBankHomeScreen extends StatefulWidget {
  final goverCode;

  final cityCode;

  final objectFromRegistration;

  final userAndTokenFromApiLoginPos;

  const BloodBankHomeScreen({super.key,required this.goverCode,required this.cityCode,required this.objectFromRegistration,required this.userAndTokenFromApiLoginPos});

  @override
  State<BloodBankHomeScreen> createState() => _BloodBankHomeScreenState();
}

class _BloodBankHomeScreenState extends State<BloodBankHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    objectFromHospitalRegistration=widget.objectFromRegistration;
    goverCode=widget.goverCode;
    cityCode=widget.cityCode;
    userAndTokenFromApiLoginPost=widget.userAndTokenFromApiLoginPos;
  }
  int indexItem=3;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBarWidget(title: 'بنك دم'),

      body: bloodBankScreenList[indexItem],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        selectedFontSize: 18,
        type: BottomNavigationBarType.fixed,
        currentIndex: indexItem,
        onTap: (index){
          setState(() {
            indexItem=index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'البحث'),
          BottomNavigationBarItem(icon: Icon(Icons.minor_crash_sharp),label: 'الإستغاثات'),
          BottomNavigationBarItem(icon: Icon(Icons.browser_updated),label: 'تحديث '),
          BottomNavigationBarItem(icon: Icon(Icons.home_work),label: 'صفحتك'),

        ],),
    );
  }
}

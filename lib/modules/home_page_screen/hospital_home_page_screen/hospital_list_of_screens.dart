import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_blood_drives/hospital_blood_drive.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_calls_screen/hospital_calls_screen.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_profile_screen/hospital_profile_screen.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_profile_screen/hospital_profile_update.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_search_screen/search_screen.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/search_screen/search_screen.dart';


 List <Widget> hospitalScreenList=[
   HospitalSearchScreen(),
   HospitalBloodDrive(),
   HospitalProfileUpdate(),
   HospitalProfileScreen(),
 ];
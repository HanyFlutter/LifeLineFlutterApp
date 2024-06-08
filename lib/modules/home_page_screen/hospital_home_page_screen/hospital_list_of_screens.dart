import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_argent_call/hospital_argent_call.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_blood_drives/hospital_blood_drive.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_orders_list/hospital_orders_list.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_profile_screen/hospital_profile_screen.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_profile_screen/hospital_profile_update.dart';
import 'package:lifeline/modules/home_page_screen/hospital_home_page_screen/hospital_search_screen/search_screen.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/search_screen/search_screen.dart';


 List <Widget> hospitalScreenList=[
   HospitalSearchScreen(),
   HospitalOrdersList(),
   HospitalBloodDrive(),
   HospitalArgentCall(),
   HospitalProfileUpdate(),
   HospitalProfileScreen(),
 ];
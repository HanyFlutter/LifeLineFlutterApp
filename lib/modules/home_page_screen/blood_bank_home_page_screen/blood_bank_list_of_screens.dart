import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_blood_drives/blood_bank_blood_drives.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_calls_screen/hospital_calls_screen.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_profile_screen/blood_bank_profile_screen.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_profile_screen/blood_bank_profile_update.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/search_screen/search_screen.dart';


 List <Widget> bloodBankScreenList=[
   SearchScreen(),
   BloodBankBloodDrive(),
   BloodBankProfileUpdate(),
   BloodBankProfileScreen(),
 ];
import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_argent_call/blood_bank_argent_call.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_blood_drives/blood_bank_blood_drives.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_orders_list/blood_bank_orders_list.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_profile_screen/blood_bank_profile_screen.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_profile_screen/blood_bank_profile_update.dart';
import 'package:lifeline/modules/home_page_screen/blood_bank_home_page_screen/blood_bank_search_screen/search_screen.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/search_screen/search_screen.dart';


 List <Widget> bloodBankScreenList=[
   BloodBankSearchScreen(),
   BloodBankOrdersList(),
   BloodBankBloodDrive(),
   BloodBankArgentCall(),
   BloodBankProfileUpdate(),
   BloodBankProfileScreen(),
 ];
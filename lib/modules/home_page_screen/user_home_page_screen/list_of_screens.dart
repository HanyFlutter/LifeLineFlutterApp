import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/heros_screen/heros_screen.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/profile_screen/profile_screen.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/search_screen/search_screen.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/user_argent_call/user_argent_call.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/user_blood_drives/user_blood_drives.dart';
import 'package:lifeline/shared/components/info_slider.dart';
import 'package:lifeline/shared/components/intro_screen.dart';


 List <Widget> screenList=[
   SearchScreen(),
   OnBoarding(isIntro: false,),
   HeroesScreen(),
   UserArgentCall(),

   UserBloodDrive(),
   ProfileScreen(),

 ];
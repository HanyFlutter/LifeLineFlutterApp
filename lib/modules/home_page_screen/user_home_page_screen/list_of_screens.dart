import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/calls_screen/calls_screen.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/heros_screen/heros_screen.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/profile_screen/profile_screen.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/search_screen/search_screen.dart';
import 'package:lifeline/shared/components/info_slider.dart';
import 'package:lifeline/shared/components/intro_screen.dart';


 List <Widget> screenList=[
   SearchScreen(),
   OnBoarding(isIntro: false,),
   HeroesScreen(),
   CallsScreen(),
   ProfileScreen(),

 ];
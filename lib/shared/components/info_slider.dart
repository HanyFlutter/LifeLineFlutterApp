
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lifeline/shared/constants.dart';



class OnBoarding extends StatelessWidget {
final isIntro;

  const OnBoarding({super.key,required bool this.isIntro});
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: OnBoardingSlider(

        controllerColor: Colors.green,
        hasFloatingButton:isIntro ,
        hasSkip:isIntro ,
        addButton: isIntro,
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Colors.blue,
        ),
        skipTextButton: isIntro?Text('Skip'):Container(),
        trailing:  isIntro?Text('login'):Container(),
        background: [ Image.asset('assets/blood_donation_info/ben0.png',width: screenWidth(context),height: (screenHeight(context)-220),),
          Image.asset('assets/blood_donation_info/ben1.png',width: screenWidth(context),height: (screenHeight(context)-150),),
          Image.asset('assets/blood_donation_info/ben2.png',width: screenWidth(context),height: (screenHeight(context)-170),),
          Image.asset('assets/blood_donation_info/ben3.png',width: screenWidth(context),height: (screenHeight(context)-150),),
          Image.asset('assets/blood_donation_info/who0.png',width: screenWidth(context),height: (screenHeight(context)-150),),
          Image.asset('assets/blood_donation_info/who1.png',width: screenWidth(context),height: (screenHeight(context)-220),),
          Image.asset('assets/blood_donation_info/who2.png',width: screenWidth(context),height: (screenHeight(context)-220),),
          Image.asset('assets/blood_donation_info/1st.png',width: screenWidth(context),height: (screenHeight(context)-220),),
          Image.asset('assets/blood_donation_info/BloodTypes.jpg',width: screenWidth(context),height: (screenHeight(context)-120),),],
        totalPage: 9,
        speed: 1,
        pageBodies: [
          Text('1'),
          Text('1'),
          Text('1'),
          Text('1'),
          Text('1'),
          Text('1'),
          Text('1'),
          Text('1'),
          Text('1'),
        ],
      ),
    );
  }
}
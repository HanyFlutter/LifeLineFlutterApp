import 'package:flutter/material.dart';
import 'package:lifeline/layout/home_screen/blood_bank_home_screen/blood_bank_home_screen.dart';
import 'package:lifeline/layout/home_screen/hospital_home_screen/hospital_home_screen.dart';
import 'package:lifeline/layout/home_screen/user_home_screen/user_home_screen.dart';
import 'package:lifeline/shared/const_hospital_details.dart';
import 'package:lifeline/modules/login_screen/login_screen.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/shared/const_text_controllers.dart';

////////////////////////
/*
to detect the screen size
*/
double screenWidth(context) => MediaQuery.of(context).size.width;
double screenHeight(context) => MediaQuery.of(context).size.height;

/////////////////////////////////
/*
global keys const
*/
final formKeyUserRegister = GlobalKey<FormState>();
final formKeyHospitalRegister = GlobalKey<FormState>();
final formKeyUpdate = GlobalKey<FormState>();
final userFormKeyUpdate = GlobalKey<FormState>();
final createBloodDriveFormKey=GlobalKey<FormState>();
final formKeyLogin = GlobalKey<FormState>();
/////////////////////////////////////////////////////

String? phoneNumberRegis,
    passwordRegis,
    rewritePasswordRegis,
    firstNameRegis,
    lastNameRegis,
    emailAddressRegis,
    passwordLog,
    donationTimesCo,
    birthDayRegis,
    emailAddressLog;
int donationTimes = 0;

/////////////////////////
/*
to control show or hidden password text
*/
bool showPasswordRegistration = true;
bool showPasswordLogin = true;

//////////////////////////////////////
/*login remember */
String userID = '';
String userToken = '';
bool rememberMe = false;
String email = '';
String password = '';
String userType = '';
bool isAuthorized() {
  if (email != '' && password != '' && userType != '') {
    return true;
  } else {
    return false;
  }
}

/*
Widget detectScreen(toController1, title,userAndTokenFromApiLoginPost) {
  if (isAuthorized()) {
    if (userType == 'شخصي') {
      return UserHomeScreen(toController1, title: title,userAndTokenFromApiLoginPos:userAndTokenFromApiLoginPost);
    } else if (userType == 'بنك دم') {
      return BloodBankHomeScreen();
    } else {
      return HospitalHomeScreen();
    }
  } else {
    return LoginScreen();
  }
}
*/

String constTitle = "";

String selectedGenderItemCode = 'm';
String? userTypeCode() {
  if (userType != '') {
    if (userType == 'شخصي') {
      return 'user';
    } else if (userType == 'مستشفى') {
      return 'hospital';
    } else if (userType == 'بنك دم') {
      return 'bloodBank';
    } else {
      return '';
    }
  }
}

Map? toControllers;
String cityCode = "1";

Map<String, dynamic> objectFromApiRegisrationPost = {};

Map proccessOfRegistrationReasponse(Map object) {
  List cityList = (hospitalsMap[object["gov"].toString()]!
      .toList()
      .firstWhere((element) => element[3] == (object["city"]))
      .toList());
  object["city"] = cityList[2];
  object["gender"] = object["gender"] == "m" ? "ذكر" : "أنثي";
  List goverList = (goverListWithItsCode
      .firstWhere((element) => element[0] == (object["gov"]))
      .toList());
  object["gov"] = goverList[1];

  object["birthDate"] = object["birthDate"].toString().split('T')[0];

  return object;
}

Map processHospitalRegistrationRespond(Map<String, dynamic> object) {
  goverCode = object["gov"];
  cityCode=object["city"];
  object["gov"] = hospitalsMap[object["gov"].toString()]?[0][0];

  hospitalsMap[goverCode.toString()]!.forEach((element) {
    element[3] == cityCode ? object["city"] = element[2] : '';
  });

  print("from the function $object");
  return object;
}
Map processBloodBankRegistrationRespond(Map<String, dynamic> object) {
  goverCode = object["gov"];
  object["gov"] = hospitalsMap[object["gov"].toString()]?[0][0];

  hospitalsMap[goverCode.toString()]!.forEach((element) {
    element[3] == cityCode ? object["city"] = element[2] : '';
  });

  print("from the function $object");
  return object;
}

Map proccessOfUpdateResponse(Map object) {
  List cityList = (hospitalsMap[object["gov"].toString()]!
      .toList()
      .firstWhere((element) => element[3] == (object["city"]))
      .toList());
  object["city"] = cityList[2];
  object["gender"] = object["gender"] == "m" ? "ذكر" : "أنثي";
  List goverList = (goverListWithItsCode
      .firstWhere((element) => element[0] == (object["gov"]))
      .toList());
  object["gov"] = goverList[1];

  object["birthDate"] = object["birthDate"].toString().split('T')[0];

  return object;
}

Map? loginReaspons = {};
Map? registrationReasponse = {};
Map? objectFromApiLoginPost = {};

Map? userAndTokenFromApiLoginPost = {};
String selectedHospitalName = hospitalsMap["$goverCode"]![0][4];
Map objectFromApiUpdatePost = {};
Map updateResponse = {};
Map objectFromHospitalRegistration = {};
String firstTimeDonation =
    '''إذا كنت تتبرع بالدم لأول مرة، فقد ينتابك شعور بالتوتر والقلق، وهذا أمر شائع. تأكد من أن الإغماء قبل أو أثناء أو بعد التبرع بالدم أمر نادر الحدوث. موظفونا موهوبون في جعل التجربة سلسة قدر الإمكان. ربما من الأفضل ألا تشاهد الإبرة عند إدخالها، واحرص كذلك على عدم رؤية الدم.''';
bool isFirstTimeOpenApp=true;
String isOwner='';
List receivedHistory=[];
List heros=[];

bool isAllowed=true;
List <dynamic> hospitalListFromApi=[];
List bloodDrives=[];
List bloodTypeOrder=[];
List bloodGroup=[];
List orderListFromApi=[];
List myOrderListFromApi=[];
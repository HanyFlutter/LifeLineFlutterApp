import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/constants.dart';

/////////////////////////////////////
/*
 selected listed and items
*/
List<String> select_list_join_as_in_registration = ['مستشفى', 'شخصي'];
List<String> select_list_join_as_in_login = ['بنك دم', 'مستشفى', 'شخصي'];
String selectedItemJoinAsLogin = select_list_join_as_in_login[2];
String selectedItemJoinAsRegistration = select_list_join_as_in_registration[1];
List<String> genderMenu = ['ذكر', 'أنثي'];
String selectedGenderItem = genderMenu[0];
List<String> bloodTypeMenu = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
String selectedBloodTypeMenu = bloodTypeMenu[0];
String selectedGoverMenu = goverListWithItsCode[0][1];
String selectedCity = hospitalsMap["$goverCode"]![0][2];
int cityIndex = 0;
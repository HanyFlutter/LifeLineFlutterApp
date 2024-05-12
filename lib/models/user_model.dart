import 'package:lifeline/network/remote/dio_helper.dart';

class UserModel{
  String? id , firstName,lastName,gender,gov,city,email,bloodType,receivedBloodType,password,birthDate,lastDonationDate,receivedBloodDate;
  int? donationTimes;
  List? disease;
  UserModel();
static Future addUser(firstName,lastname,email,password,birthDate,gender,phone,bloodType,gov,city,disease,donationTimes)async{
 return await DioHelper.postData(url: 'user', data: {
   'firstName':firstName,'lastname':lastname,'email':email,'password':password,'birthDate':birthDate,'gender':gender,'phone':phone,'bloodType':bloodType,'gov':gov,'city':city,'disease':disease,'donationTimes':donationTimes
 });
}
validateUserData(){}
login(){}
authenticate(){}
modify(){}
getUserData(){}
}
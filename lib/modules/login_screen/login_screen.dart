import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/layout/home_screen/user_home_screen/user_home_screen.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared//constants.dart';
import 'package:lifeline/shared/components/app_bar.dart';
import 'package:lifeline/shared/components/login_button.dart';
import 'package:lifeline/shared/components/password_text.dart';
import 'package:lifeline/shared/components/select_account_type.dart';
import 'package:lifeline/shared/components/tail_of_login_screen.dart';
import 'package:lifeline/shared/components/toast_msg.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
import 'package:lifeline/shared/const_validation.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
bool checkBoxValue=false;
  void toggleEye() {
    setState(() {
      showPasswordLogin = !showPasswordLogin;
    });
  }
  double opacityValue =0;
  Future timer () async{
    await SharedPreferencesHelper.init();

    Future.delayed(Duration(milliseconds: 100),(){
      setState(() {
        opacityValue=1;
      });
    });
  }
  @override
  void initState() {
    timer();

    print('prom login init state');
try{
  print(" before id $userID remember $rememberMe token $userToken");

  SharedPreferencesHelper.getString(key: 'userID').then((value) => userID=value).catchError((e)=>print(e.toString()));
  SharedPreferencesHelper.getString(key: 'userToken').then((value) => userToken=value).catchError((e)=>print(e.toString()));
  SharedPreferencesHelper.getBool(key: 'rememberMe').then((value) { rememberMe=value;

  print("after id $userID remember $rememberMe token $userToken");

  if(rememberMe==true && userID !='' && userToken !=''){

    print("good to here");

    try {
      DioHelper.getData(url: 'user/profile', header: {
        "authentication": userToken
      }, data: {
        "userID": userID
      }).then((value)async {
        await SharedPreferencesHelper.setString(
            key: 'userID',
            value: userID);
        await SharedPreferencesHelper.setString(
            key: 'userToken',
            value: userToken);
        await SharedPreferencesHelper.setBool(key: 'rememberMe',value: rememberMe);
        objectFromApiLoginPost = value.data;
        print("from auto login screen  $objectFromApiLoginPost");
        loginReaspons = proccessOfRegistrationReasponse(
            objectFromApiLoginPost!["user"]);
        constTitle = loginReaspons!["firstName"];
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UserHomeScreen(loginReaspons,title:constTitle,userAndTokenFromApiLoginPos:userAndTokenFromApiLoginPost!),
        ));
      });


    } catch (er) {
      print(er.toString());
      showToast(context);
    }
  }
  }).catchError((e)=>print(e.toString()));

}catch(e){
  print(e.toString());
  showToast(context);
}
    // TODO: implement initState
    super.initState();




  }
  Widget SelectAccountType2 (){
    return Row (children: [
      Text(' الدخول كحساب ',style: TextStyle(fontSize: 14),),
      Center(
        child: DropdownButton<String>(
          value: selectedItemJoinAsLogin,// Default value
          onChanged: (String? newValue) {
            setState(() {
              selectedItemJoinAsLogin=newValue!;

            });
            // Handle dropdown item selection
            print(selectedItemJoinAsLogin);
          },
          items: select_list_join_as_in_login.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(fontSize: 14,color: Colors.blue),),
            );
          }).toList(),
        ),


      )],);
  }
  @override
  Widget build(BuildContext context) {

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: appBarWidget(title: 'تسجيل الدخول'),
      body:  Center(
        child: SingleChildScrollView(
          child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKeyLogin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: screenWidth(context) / 2,
                    height: screenWidth(context) / 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SelectAccountType2(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (String? val) {
                      return validateEmail(val!);
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emailAddressLogin,
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  passwordLoginText(
                      controller: passwordLogin,
                      showPassword: showPasswordLogin,
                      toggel: toggleEye,
                      labelText: 'كلمة المرور'),
                  Center(child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Text('تذكرني ',style: TextStyle(fontSize: 16),),

                      Checkbox(value: checkBoxValue, onChanged: (v)async{
                        setState(()  {
                          checkBoxValue=v!;
                          SharedPreferencesHelper.setBool(key: 'rememberMe', value: v);
                          rememberMe=checkBoxValue;

                        });
                        print(rememberMe);
                      })
                    ],),),
                  SizedBox(
                    height: 10,
                  ),
                  loginButton(width: screenWidth(context) / 2, text: 'دخول',context: context),
                  SizedBox(
                    height: 10,
                  ),
                  tailOfLoginScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
    ));


  }
}

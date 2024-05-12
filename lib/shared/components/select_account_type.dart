import 'package:flutter/material.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';

import '../../shared/constants.dart';
class Drop extends StatefulWidget {
  final int ScreenType;
  const Drop({required this.ScreenType});

  @override
  State<Drop> createState() => _DropState(ScreenType:ScreenType);
}

class _DropState extends State<Drop> {

  final int ScreenType;
  _DropState({required this.ScreenType});


  Widget SelectAccountType (){
    return Row (children: [
      Text(' التسجيل كحساب ',style: TextStyle(fontSize: 14),),
      Center(
        child: DropdownButton<String>(
          value: selectedItemJoinAsRegistration,// Default value
          onChanged: (String? newValue) {
            setState(() {
              selectedItemJoinAsRegistration=newValue!;

            });
            // Handle dropdown item selection
            print('Selected: $newValue');
          },
          items: select_list_join_as_in_registration.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(fontSize: 14,color: Colors.blue),),
            );
          }).toList(),
        ),


      )],);
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
            print('Selected: $newValue');
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
  Widget SelectGender (){
    return Row (children: [
      Text(' النوع ',style: TextStyle(fontSize: 14),),
      Center(
        child: DropdownButton<String>(
          value: selectedGenderItem,// Default value
          onChanged: (String? newValue) {
            setState(() {
              selectedGenderItem=newValue!;
              selectedGenderItemCode=newValue=="ذكر"? "m":"f";

            });
            // Handle dropdown item selection
            print('Selected: $newValue');
          },
          items: genderMenu.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(fontSize: 14,color: Colors.blue),),
            );
          }).toList(),
        ),


      )],);
  }
  Widget BloodType (){
    return Row (children: [
      Text('إختر فصيلة الدم  ',style: TextStyle(fontSize: 14),),
      Center(
        child: DropdownButton<String>(
          value:  selectedBloodTypeMenu,// Default value
          onChanged: (String? newValue) {
            setState(() {
              selectedBloodTypeMenu=newValue!;

            });
            // Handle dropdown item selection
            print('Selected: $newValue');
          },
          items: bloodTypeMenu.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(fontSize: 14,color: Colors.blue),),
            );
          }).toList(),
        ),


      )],);
  }
  Widget SelectWidget( ){

    if (ScreenType==2){
      return SelectAccountType ();
    }
    if (ScreenType==3){
      return SelectGender ();
    }
    if (ScreenType==4){
      return BloodType ();
    }
    if (ScreenType==5){
      return SelectAccountType2 ();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return SelectWidget();
  }
}




import 'package:flutter/material.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Widget selectGover(){
    return Row(
      children: [
        Card(child:         Text(
          ' إبحث عن مستشفيات في محافظة   ',
          style: TextStyle(fontSize: 14),
        ) ,),
        Center(
          child: DropdownButton<String>(
            value: selectedGoverMenu, // Default value
            onChanged: (String? newValue) {
              setState(() {

                cityIndex = 0;
                selectedGoverMenu = newValue!;
                goverListWithItsCode.forEach(
                        (e) => e[1] == selectedGoverMenu ? goverCode = e[0] : 0);

                selectedHospitalName = hospitalsMap[goverCode]![0][4];
                selectedCity = hospitalsMap[goverCode]![0][2];

                print('gover code is $goverCode');
              });

              // Handle dropdown item selection
            },
            items: goverListWithItsCode.map((value) {
              return DropdownMenuItem<String>(
                value: value[1],
                child: Text(
                  value[1],
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Directionality(textDirection: TextDirection.rtl, child: Padding(padding: EdgeInsets.all(10),child: Center(child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child:
        Column(children: [
          selectGover(),
SizedBox(height: 10,),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: hospitalsMap["$goverCode"]!.length,
              itemBuilder: (ctx,index){
                return Card(child: Column(children: [
                  Text('  إسم المدينة  ${hospitalsMap["$goverCode"]![index][2]}',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('  إسم المستشفى  ${hospitalsMap["$goverCode"]![index][4]}',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('  العنوان   ${hospitalsMap["$goverCode"]![index][5]}',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '  رقم الهاتف :  ${hospitalsMap["$goverCode"]![index][6]} ',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],),);
              }),
        ],)
        ,)),))
    );
  }
}

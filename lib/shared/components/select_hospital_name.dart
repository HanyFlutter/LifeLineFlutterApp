import 'package:flutter/material.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/constants.dart';

class SelectHospitalName extends StatefulWidget {
  const SelectHospitalName({super.key});

  @override
  State<SelectHospitalName> createState() => _SelectHospitalNameState();
}

class _SelectHospitalNameState extends State<SelectHospitalName> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' إسم المستشفى  ',
          style: TextStyle(fontSize: 14),
        ),
        Center(
          child: DropdownButton<String>(
            value: selectedHospitalName, // Default value

            onChanged: (String? newValue) {
              setState(() {
                selectedHospitalName = newValue!;
                hospitalsMap["$goverCode"]!.forEach((element) {
                  element[4] == newValue
                      ? cityIndex = hospitalsMap["$goverCode"]!.indexOf(element)
                      : '';
                });
                cityCode = hospitalsMap["$goverCode"]![cityIndex][3];

              });



              // Handle dropdown item selection
              print('Selected: $selectedCity');
            },
            items: hospitalsMap["$goverCode"]!.map((value) {
              return DropdownMenuItem<String>(
                value: value[4],
                child: Text(
                  value[4],
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );  }
}

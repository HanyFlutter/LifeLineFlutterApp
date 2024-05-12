import 'package:flutter/material.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/constants.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({super.key});

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' المدينة ',
          style: TextStyle(fontSize: 14),
        ),
        Center(
          child: DropdownButton<String>(
            value: selectedCity, // Default value
            onChanged: (String? newValue) {
              setState(() {
                selectedCity = newValue!;

                hospitalsMap["$goverCode"]!.forEach((element) {
                  element[2] == selectedCity
                      ? cityIndex = hospitalsMap["$goverCode"]!.indexOf(element)
                      : '';
                  cityCode = hospitalsMap["$goverCode"]![cityIndex][3];

                });
                print(cityIndex);
              });

              // Handle dropdown item selection
              print('Selected: $selectedCity');
            },
            items: hospitalsMap["$goverCode"]!.map((value) {
              return DropdownMenuItem<String>(
                value: value[2],
                child: Text(
                  value[2],
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );  }
}

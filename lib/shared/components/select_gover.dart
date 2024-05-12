import 'package:flutter/material.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/const_of_selected_lists_and_items.dart';
import 'package:lifeline/shared/constants.dart';
class SelectGover extends StatefulWidget {
  const SelectGover({super.key});

  @override
  State<SelectGover> createState() => _SelectGoverState();
}

class _SelectGoverState extends State<SelectGover> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' المحافظة  ',
          style: TextStyle(fontSize: 14),
        ),
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
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}



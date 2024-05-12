import 'package:flutter/material.dart';
import 'package:lifeline/shared/const_hospital_deteals.dart';
import 'package:lifeline/shared/constants.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class DiseasesSelect extends StatefulWidget {
  const DiseasesSelect({super.key});

  @override
  State<DiseasesSelect> createState() => _DiseasesSelectState();
}

class _DiseasesSelectState extends State<DiseasesSelect> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MultiSelectController _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: this._scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 800,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text('إختر من القائمة'),
                  SizedBox(
                    height: 20,
                  ),
                  MultiSelectDropDown(
                    controller: _controller,
                    onOptionSelected: (options) {
                      print(_controller.enabledOptions);
                      listOfDiseasesSelectedValue = [];
                    },
                    options: <ValueItem>[
                      ValueItem(label: listOfDiseases[0], value: '1'),
                      ValueItem(label: listOfDiseases[1], value: '2'),
                      ValueItem(label: listOfDiseases[2], value: '3'),
                      ValueItem(label: listOfDiseases[3], value: '4'),
                      ValueItem(label: listOfDiseases[4], value: '5'),
                      ValueItem(label: listOfDiseases[5], value: '6'),
                      ValueItem(label: listOfDiseases[6], value: '7'),
                      ValueItem(label: listOfDiseases[7], value: '8'),
                      ValueItem(label: listOfDiseases[8], value: '9'),
                      ValueItem(label: listOfDiseases[9], value: '10'),
                      ValueItem(label: listOfDiseases[10], value: '11'),
                      ValueItem(label: listOfDiseases[11], value: '12'),
                      ValueItem(label: listOfDiseases[12], value: '13'),
                      ValueItem(label: listOfDiseases[13], value: '14'),
                      ValueItem(label: listOfDiseases[14], value: '15'),
                      ValueItem(label: listOfDiseases[15], value: '16'),
                      ValueItem(label: listOfDiseases[16], value: '17'),
                      ValueItem(label: listOfDiseases[17], value: '18'),
                    ],
                    maxItems: 5,
                    //disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    dropdownHeight: 600,
                    optionTextStyle: const TextStyle(fontSize: 12),
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                   Color.fromARGB(255, 179, 17, 17))),
                            onPressed: () {
                              Navigator.pop(context, []);
                            },
                            child: Text(
                              'الغاء ',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 2, 88, 5))),
                            onPressed: () {
                              _controller.selectedOptions.forEach((element) {
                                listOfDiseasesSelectedValue
                                    .add(element.label.toString());
                              });

                              Navigator.pop(
                                  context, listOfDiseasesSelectedValue);

                            },
                            child: Text(
                              'تم الاختيار ',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

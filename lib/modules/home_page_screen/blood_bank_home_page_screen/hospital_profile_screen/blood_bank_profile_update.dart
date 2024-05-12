import 'package:flutter/material.dart';
import 'package:lifeline/shared/components/app_bar.dart';
import 'package:lifeline/shared/components/blood_bank_update_button.dart';
import 'package:lifeline/shared/constants.dart';

class BloodBankProfileUpdate extends StatefulWidget {
  BloodBankProfileUpdate({super.key, this.toControllers});
  final toControllers;

  @override
  State<BloodBankProfileUpdate> createState() => _BloodBankProfileUpdateState();
}

class _BloodBankProfileUpdateState extends State<BloodBankProfileUpdate> {
  @override
  @override
  void toggelEye() {
    setState(() {
      showPasswordRegistration = !showPasswordRegistration;
    });
  }

  bool changePassword = false;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Text(
                    'تحديث أكياس الدم',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          objectFromHospitalRegistration["bloodGroup"].length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ListTile(
                                        leading: CircleAvatar(
                                          child: Text(
                                            objectFromHospitalRegistration[
                                                    "bloodGroup"][index]
                                                ["bloodType"],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'عدد أكياس الدم',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    objectFromHospitalRegistration["bloodGroup"][index]["count"] =
                                                        objectFromHospitalRegistration["bloodGroup"]
                                                            [index]["count"]+1;
                                                    print(objectFromHospitalRegistration[
                                                    "bloodGroup"]
                                                    [index]
                                                    ["count"]);
                                                  });
                                                },
                                                icon: CircleAvatar(child: Icon(Icons.add),)),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              objectFromHospitalRegistration[
                                                          "bloodGroup"][index]
                                                      ["count"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.blueAccent),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    objectFromHospitalRegistration[
                                                                        "bloodGroup"]
                                                                    [index]
                                                                ["count"] >
                                                            0
                                                        ? objectFromHospitalRegistration[
                                                                    "bloodGroup"]
                                                                [
                                                                index]["count"] =
                                                            objectFromHospitalRegistration[
                                                                    "bloodGroup"]
                                                                [
                                                                index]["count"]-1
                                                        : 0;
                                                  });
                                                },
                                                icon: CircleAvatar(child: Icon(Icons.remove),)),
                                            SizedBox(
                                              width: 3,
                                            ),
                                          ],
                                        )))));
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                BloodBankUpdateButton()
              ],
            ),
          )
        ],
      ),
    ));
  }
}

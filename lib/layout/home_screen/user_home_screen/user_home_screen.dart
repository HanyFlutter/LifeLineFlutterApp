import 'package:flutter/material.dart';
import 'package:lifeline/modules/home_page_screen/user_home_page_screen/list_of_screens.dart';
import 'package:lifeline/network/local/shared_preferences_helper.dart';
import 'package:lifeline/network/remote/dio_helper.dart';
import 'package:lifeline/shared/components/app_bar.dart';
import 'package:lifeline/shared/constants.dart';

class UserHomeScreen extends StatefulWidget {
  final toController;
  final title;
final userAndTokenFromApiLoginPos;
  UserHomeScreen(this.toController, {super.key,required this.title, Map? this.userAndTokenFromApiLoginPos});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {

      DioHelper.getDataWithoutBody(url: 'user/Heros', header: {
        "authentication": userToken,
        "Content-Type":"application/json"
      }
      ).then((value){heros=value.data;
      }).catchError((err){print(err.toString());})

      ;}catch(e){print(e.toString());};
  }
  _UserHomeScreenState();

  int indexItem = 4;

  @override
  Widget build(BuildContext context) {
    toControllers = widget.toController;
      constTitle=toControllers!["firstName"]??"";
    userAndTokenFromApiLoginPost=widget.userAndTokenFromApiLoginPos;
    userID=userAndTokenFromApiLoginPost!["userID"]??'';
    userToken=userAndTokenFromApiLoginPost!["token"]??'';
    print("user id $userID token $userToken");

    print('from home  ${widget.toController.toString()}');
    return Scaffold(
      appBar: appBarWidget(title: widget.title),
      body: screenList[indexItem],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        selectedFontSize: 16,

        type: BottomNavigationBarType.fixed,
        currentIndex: indexItem,
        onTap: (index) {
          setState(() {
            indexItem = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'البحث'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'لمعلوماتك'),
          BottomNavigationBarItem(icon: Icon(Icons.wine_bar), label: 'الأبطال'),
          BottomNavigationBarItem(icon: Icon(Icons.minor_crash_sharp), label: 'الحملات'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'صفحتك'),
        ],
      ),
    );
  }
}

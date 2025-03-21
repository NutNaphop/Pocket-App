import 'package:flutter/material.dart';
import 'package:locket_mockup/Pages/MainSection/WelcomePage.dart';
import 'package:locket_mockup/Pages/SettingSection/EditUsername.dart';
import 'package:locket_mockup/components/BottomSheet/DeleteSheet.dart';
import 'package:locket_mockup/components/ListTile/SettingMenu.dart';
import 'package:locket_mockup/providers/CameraProvider.dart';
import 'package:locket_mockup/providers/UserProvider.dart';
import 'package:locket_mockup/service/CRUD.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var camProvider = Provider.of<CameraProvider>(context);
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    var user_info = userProvider.userData;
    var profileUrl = user_info?["profile"];

    void deleteAccount() {
      deleteUserAccount();
    }

    List generalSetting = [
      {
        "menuText": "Edit Profile",
        "icon": Icons.label_outline,
        "onTap": (BuildContext context) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditUsernamePage()),
          );
        }
      }
    ];
    List dangerSetting = [
      {
        "menuText": "Delete Account",
        "icon": Icons.delete_outline,
        "onTap": (BuildContext context) {
          DeleteSheet obj = DeleteSheet(
              title: "Do you sure to delete your account?",
              prop_function: deleteAccount);
          obj.showDeleteConfirmationBottomSheet(context);
          // เพิ่มโค้ดลบบัญชีที่นี่
        }
      },
      {
        "menuText": "Sign Out",
        "icon": Icons.delete,
        "onTap": (BuildContext context) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage()),
            (Route<dynamic> route) => false, // ลบหน้าทั้งหมดใน stack
          );
          userProvider.logout();
          // เพิ่มโค้ดลบบัญชีที่นี่
        }
      }
    ];

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.white,
            )),
        title: Text("Settings",
            style: TextStyle(fontSize: 24, color: Colors.white , fontFamily: "Josefin Sans" , fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                width: 30,
                height: 30,
              ),
              profileUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(profileUrl),
                      radius: 60,
                    )
                  : Icon(
                      Icons.account_circle_outlined,
                      size: 80,
                      color: Colors.white,
                    ),
              SizedBox(
                width: 30,
                height: 10,
              ),
              Text(
                user_info?["name"] ?? "Username",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.person,
                    size: 32,
                    color: Colors.white,
                  ),
                  Text(
                    "General",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold ,
                        fontFamily: "Josefin Sans"
                        ),
                  )
                ],
              ),
              SizedBox(height: 10),
              SettingMenu(menuMap: generalSetting[0]),
              SizedBox(
                height: 50,
              ),
              Row(
                spacing: 5,
                children: [
                  Icon(
                    Icons.report_outlined,
                    size: 32,
                    color: Colors.white,
                  ),
                  Text(
                    "Danger Zone",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold ,
                        fontFamily: "Josefin Sans"
                        ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                spacing: 20,
                children: [
                  for (var i = 0; i < dangerSetting.length; i++)
                    SettingMenu(menuMap: dangerSetting[i]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

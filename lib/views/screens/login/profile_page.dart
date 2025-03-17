import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';

import 'package:yemen_travel_guid/models/auth/profile_model.dart';
import 'package:yemen_travel_guid/views/screens/office/office_page.dart';
import 'package:yemen_travel_guid/views/screens/setting_page.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/constant.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  late ProfileModel user;
  bool loading = true;

  void _getProfile() async {
    setState(() {
      loading = true;
    });
    var response = await getProfile();
    if (response.error == null) {
      user = response.data as ProfileModel;
    } else {
      showErrorSnackBar(context: context, message: response.error.toString(), );
    }
    setState(() {
      loading = false;
    });
  }



  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  Widget build(BuildContext context) {

    return  loading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 50.0, right: 44, bottom: 10),
            child: Text('الحساب', style: TextStyle(fontSize: 22,
                color: AppColors.primary2,
                fontWeight: FontWeight.bold),),
          ),
          ListTile(
            title: Text(
              user.userName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.grey[900]),
            ),
            subtitle: Text(user.email),
            trailing: Text(user.role!),
            leading: CircleAvatar(
              radius: 30.0,
              // backgroundImage: NetworkImage("${snapshot.data.hitsList[index].previewUrl}"),
            ),
          ),



          const Divider(),
          ListTile(
            title: Text('الإعدادات',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[900])),
            leading: Icon(Icons.settings, color: Colors.grey[700]),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const SettingPage()));
            },
          ),
          const Divider(),
          ListTile(
            title: Text('تواصل معنا',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[900])),
            leading: Icon(Icons.phone, color: Colors.grey[700]),
            onTap: () {
            },
          ),
          const Divider(),
          ListTile(
            title: Text('الدعم',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[900])),
            leading: Icon(Icons.help, color: Colors.grey[700]),
            onTap: () {
            },
          ),
          const Divider(),
          if(user.role == 'Agent')
          ListTile(
            title: Text('ادارة المكتب',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[900])),
            leading: Icon(Icons.home_work, color: Colors.grey[700]),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const OfficePage()));

            },
          ),
          if(user.role == 'Agent')
          const Divider(),

          ListTile(
            title: Text('تسجيل خروج',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[900])),
            leading: Icon(Icons.logout, color: Colors.grey[700]),
            onTap: () {
              unauthorizedLogout(context);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

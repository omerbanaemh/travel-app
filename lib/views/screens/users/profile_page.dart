import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/cor/util/snackbar_message.dart';
import 'package:yemen_travel_guid/models/auth/profile_model.dart';
import 'package:yemen_travel_guid/views/screens/setting_page.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  late ProfileModel user;
  bool loading = true;
  @override
  void initState() {
    _getProfile();
    super.initState();
  }


  void _getProfile() async {
    print('--------------------------------');
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
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // SizedBox(height: 22,),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 36.0, right: 44, bottom: 22),
                  child: Text('الحساب', style: TextStyle(fontSize: 22,
                      color: AppColors.primary2,
                      fontWeight: FontWeight.bold),),
                ),

                loading ? Center(child: CircularProgressIndicator()) :
                ListTile(
                  title: Text(
                    user.userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.grey[900]),
                  ),
                  subtitle: Text(user.email),
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
              ],
            )),
      ],
    );
  }
}

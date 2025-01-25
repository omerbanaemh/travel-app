import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.primary6, //change your color here
        ),
        title: Text('الإعدادات',style: TextStyle(fontSize: 20,color: AppColors.primary2,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ListTile(
                    title: Text('اللغة',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[900])),
                    leading: Icon(Icons.language, color: Colors.grey[700]),
                    onTap: () {
                      // unauthorizedLogout(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('تغيير الحساب الألكتروني',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[900])),
                    leading: Icon(Icons.person_outline, color: Colors.grey[700]),
                    onTap: () {
                      // unauthorizedLogout(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('تغيير رقم الهاتف',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[900])),
                    leading: Icon(Icons.local_phone_outlined, color: Colors.grey[700]),
                    onTap: () {
                      // unauthorizedLogout(context);
                    },
                  ),
                  const Divider(),

                  ListTile(
                    title: Text('تغيير كلمة السر',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[900])),
                    leading: Icon(Icons.password, color: Colors.grey[700]),
                    onTap: () {
                      // unauthorizedLogout(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('سياسة الخصوصية',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[900])),
                    leading: Icon(Icons.menu_book, color: Colors.grey[700]),
                    onTap: () {
                      // unauthorizedLogout(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('الوضع',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[900])),
                    leading: Icon(Icons.brightness_4, color: Colors.grey[700]),
                    onTap: () {
                      // unauthorizedLogout(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('حذف الحساب',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[900])),
                    leading: Icon(Icons.delete_outline, color: Colors.grey[700]),
                    onTap: () {
                      // unauthorizedLogout(context);
                    },
                  ),
                  const Divider(),
                ],
              )),
        ],
      ),
    );;
  }
}

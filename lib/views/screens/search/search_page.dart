import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بحث', style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: AppColors.primary3)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,bottom: 16.0,right: 16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'البحث عن وجهات وأشياء للقيام بها...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: AppColors.primary4,size: 33,),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColors.primary3, ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColors.primary3, width:  1.3),
                ),
              ),
            ),
            SizedBox(height: 20),
            // عنوان الاقتراحات

            // قائمة الاقتراحات
            Expanded(
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'اقتراحات',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: AppColors.primary3),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Text('قرية رجال المع التراثية',),
                    subtitle: Text('معلم سياحي'),
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset('assets/images/noImage.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

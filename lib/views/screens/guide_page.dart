import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/views/screens/aboutYemen/about_yemen_page.dart';
import 'package:yemen_travel_guid/views/screens/aboutYemen/navigation_guide_page.dart';
import 'package:yemen_travel_guid/views/screens/aboutYemen/travel_guide_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/views/screens/governorates/governorates_page.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 230,
              width: double.infinity,
              child: Image.asset('assets/images/guide/banner_guide.png',fit: BoxFit.cover,)
          ),
          Container(
              width: double.infinity,
              child: Image.asset('assets/images/home/underbanner.png',fit: BoxFit.cover,)
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutYemenPage()));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: 128,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/guide/yemen.png',fit: BoxFit.cover,)
                      ),
                  ),
                ),
                Expanded(child: Text('حول اليمن',style: TextStyle(fontSize: 24,color: Color(
                    0xffa76f47)),))
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TravelGuidePage()));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: 128,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/guide/guide.png',fit: BoxFit.cover,)
                    ),
                  ),
                ),
                Expanded(child: Text('دليل السفر',style: TextStyle(fontSize: 24,color: Color(
                    0xffa76f47)),))
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationGuidePage()));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: 128,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/guide/travel.png',fit: BoxFit.cover,)
                    ),
                  ),
                ),
                Expanded(child: Text('دليل التنقل',style: TextStyle(fontSize: 24,color: Color(
                    0xffa76f47)),))
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GovernoratesPage()));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: 128,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SvgPicture.asset('assets/images/guide/governorates.svg',fit: BoxFit.cover,)
                    ),
                  ),
                ),
                Expanded(child: Text('المحافظات',style: TextStyle(fontSize: 24,color: Color(
                    0xffa76f47)),))
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

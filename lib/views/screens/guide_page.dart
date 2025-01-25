import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/views/screens/about_yemen_page.dart';

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
              child: Image.asset('assets/images/guide/guide.png',fit: BoxFit.cover,)
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
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 157,
                      height: 129,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/guide/yemen.png',fit: BoxFit.cover,)
                      ),
                  ),
                ),
                Expanded(child: Center(child: Text('حول اليمن',style: TextStyle(fontSize: 36,color: Color(
                    0xffa76f47)),)))
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: (){},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 157,
                    height: 129,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/home/underbanner.png',fit: BoxFit.cover,)
                    ),
                  ),
                ),
                Expanded(child: Center(child: Text('الثقافة',style: TextStyle(fontSize: 36,color: Color(
                    0xffa76f47)),)))
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: (){},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 157,
                    height: 129,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/guide/travel.png',fit: BoxFit.cover,)
                    ),
                  ),
                ),
                Expanded(child: Center(child: Text('دليل التنقل',style: TextStyle(fontSize: 36,color: Color(
                    0xffa76f47)),)))
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

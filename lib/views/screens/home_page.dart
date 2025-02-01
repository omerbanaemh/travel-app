import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> images = [
    'assets/images/banner.png',
    'assets/images/banner.png',
    'assets/images/banner.png',
    'assets/images/banner.png',
  ];
  final List<Map<String, String>> destinations = [
    {'image': 'assets/images/banner.png', 'label': 'شارع' },
    {'image': 'assets/images/banner.png', 'label': 'سقطرى'},
    {'image': 'assets/images/banner.png', 'label': 'عدن'  },
    {'image': 'assets/images/banner.png', 'label': 'شبام' },
  ];
  final List<Map<String, String>> activities = [
    {'image': 'assets/images/banner.png', 'label': 'نشاط 1','description': 'عدن هي  '},
    {'image': 'assets/images/banner.png', 'label': 'حضرموت-شبام2','description': 'ناطحات السحاب الطينية'},
    {'image': 'assets/images/banner.png', 'label': ' نشاط نشاط 2نشاط نشاط','description': 'عدن هي مدينة ساحلية في اليمن لقبثي للايبثل للارقبي '},
    {'image': 'assets/images/banner.png', 'label': 'نشاط 2','description': 'عدن هي مدينة ساحلية في اليمن '},
  ];
  final List<Map<String, String>> experiences = [
    {'image': 'assets/images/banner.png', 'label': 'تجربة 1'},
    {'image': 'assets/images/banner.png', 'label': 'تجربة 2'},
    {'image': 'assets/images/banner.png', 'label': 'تجربة 2'},
    {'image': 'assets/images/banner.png', 'label': 'تجربة 2'},
    // ... أضف المزيد من التجارب
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                width: double.infinity,
                child: Image.asset(images[index], fit: BoxFit.cover),
              );
            },
            options: CarouselOptions(
              height: 230,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              enlargeCenterPage: false,
            ),
          ),
          Container(
              width: double.infinity,
              child: Image.asset('assets/images/home/underbanner.png',fit: BoxFit.cover,)
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10,top: 5,bottom: 5),
            child: Text('وجهات السفر',style: TextStyle(fontSize: 20,color: AppColors.primary2,),),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: destinations.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    width: 100,
                    padding: EdgeInsets.only(right: 10,),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/home/map.png',
                                fit: BoxFit.cover,
                                width: 73,
                                height: 70,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'الكل',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: VerticalDivider(
                            color: Color(0xcbb88c6c),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  final dynamicIndex = index - 1;
                  return Container(
                    width: 100,
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            destinations[dynamicIndex]['image']!,
                            fit: BoxFit.cover,
                            width: 73,
                            height: 70,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          destinations[dynamicIndex]['label']!,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10,bottom: 5),
            child: Text('انشطة يجب القيام بها',style: TextStyle(fontSize: 20,color: AppColors.primary2,),),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 18,bottom: 11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1.0),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            activities[index]['image']!,
                            fit: BoxFit.cover,
                            height: 100,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Container(
                        padding:EdgeInsets.only(top:5.0),
                        child: Text(
                          activities[index]['label']!,
                          style: TextStyle(fontSize: 13,color: Color(0xff81400c),fontFamily: 'Simplified_Arabic_Fixed'),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        height:37,
                        child: Text(
                          activities[index]['description']!,
                          style: TextStyle(fontSize: 13,color: AppColors.titleColor,fontFamily: 'Simplified_Arabic_Fixed',),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap:(){},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.primary3,
                          ),

                          child: Padding(
                            padding: const EdgeInsets.only(left: 22,right: 22,top: 2),
                            child: Text('تعرف اكثر',style: TextStyle(color: Colors.white,fontSize: 12),),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10,bottom: 5),
            child: Text('افضل التجارب',style: TextStyle(fontSize: 20,color: AppColors.primary2,),),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  height: 100,
                  margin: EdgeInsets.only(right: 10, left:12, bottom: 11),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1.0),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      activities[index]['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}

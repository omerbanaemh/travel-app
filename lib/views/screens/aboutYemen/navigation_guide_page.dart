import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationGuidePage extends StatelessWidget {
  const NavigationGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Stack(
          children:[
            Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0,left: 8,bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80,),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey),
                      ),
                      width: 360,
                      height: 215,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset('assets/images/guide/travel.png',fit: BoxFit.cover,)
                      ),
                    ),
                    const SizedBox(height: 30,),
                    const Text('النقل داخل اليمن',textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFA87247)
                    ),),
                    const Text('يمكن أن يتم عبر عدة وسائل :',textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 20,
                    ),),

                    Padding(
                      padding: const EdgeInsets.only(right: 12,),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: '1.النقل الجماعي: ',style: TextStyle(color: Color(0xffa76f47),fontSize: 20),),
                            TextSpan(text: 'يوفر العديد من شركات النقل الجماعي خدماتها في جميع أنحاء البلاد. يمكنك حجز تذاكر النقل الجماعي عبر الإنترنت أو الهاتف أو من خلال مكاتب الشركات. ',),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12,),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: '2.السيارات الخاصة: ',style: TextStyle(color: Color(0xffa76f47),fontSize: 20),),
                            TextSpan(text: 'يمكن استئجار سيارات خاصة . ',),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12,),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: '3.السيارات الأجرة : ',style: TextStyle(color: Color(0xffa76f47),fontSize: 20),),
                            TextSpan(text: 'يمكن أستخدامها في المشاوير اليومية إذا كنت لا تفضل الحافلات ',),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12,),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: '4.الحافلات: ',style: TextStyle(color: Color(0xffa76f47),fontSize: 20),),
                            TextSpan(text: 'توفر الحافلات خدمات النقل بين المدن الرئيسية والمناطق الريفية.',),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12,),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: '5.الطيران الداخلي: ',style: TextStyle(color: Color(0xffa76f47),fontSize: 20),),
                            TextSpan(text: 'يمكنك السفر بالطائرة بين المدن الكبرى في اليمن، حيث توجد عدة مطارات تقدم رحلات داخلية..',),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12, bottom: 10),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: '6.المواصلات البحرية: ',style: TextStyle(color: Color(0xffa76f47),fontSize: 20),),
                            TextSpan(text: 'يمكن استخدام السفينة البحرية للذهاب إلى سقطرى.',),
                          ],
                        ),
                      ),
                    ),
                const Padding(
                  padding: EdgeInsets.only(right: 12, bottom: 10),
                    child: Text('بينما الوسائل اللأكثر شيوعاً هي السيارات الأجرة و الحافلات ',style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                ),

                  ],
                ),
              ),
            ],
          ),
            Positioned(
              top: 40,
              right: 10,
              child:
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SvgPicture.asset(
                        'assets/images/back.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}

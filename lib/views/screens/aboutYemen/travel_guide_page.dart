import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TravelGuidePage extends StatelessWidget {
  const TravelGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children:[
                Container(
                  height: 230,
                  width: double.infinity,
                  child: Image.asset('assets/images/about_yemen/group.png',fit: BoxFit.cover,)
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
            Container(
                width: double.infinity,
                child: Image.asset('assets/images/home/underbanner.png',fit: BoxFit.cover,)
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0,left: 8,bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('معلومات مهمة عند زيارتك لليمن',textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 32,
                      color: Color(0xffa76f47),
                  ),),
                  SizedBox(height: 22,),
                  Text('الفصول خلال السنة ',textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 32,
                      color: Color(0xffa76f47),
                  ),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 360,
                    height: 215,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/about_yemen/seasons.png',fit: BoxFit.cover,)
                    ),
                  ),
                  Text('فصل الصيف ',textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 32,
                  ),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 360,
                    height: 215,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/about_yemen/summer.png',fit: BoxFit.cover,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 12,top: 12),
                    child: Text('الصيف في اليمن يتميز بطقس حار جداً، خصوصاً في المناطق الساحلية  مثل عدن و حضرموت حيث تصل درجات الحرارة إلى مستويات عالية قد تكون غير مريحة للسكان والزوار على حد سواء. في المناطق الجبلية مثل صنعاء، يكون الطقس أقل حرارة لكن لا يزال دافئًا، مما يجعلها وجهة أفضل للهروب من الحر الشديد. هذا الفصل هو الوقت المثالي للأنشطة البحرية مثل السباحة والغوص في المياه الزرقاء الصافية، لكن يجب أخذ الحيطة من أشعة الشمس القوية والتأكد من البقاء مرطبًا وتجنب التعرض المباشر للشمس لفترات طويلة. يُفضل القيام بالنشاطات الخارجية في الصباح الباكر أو بعد غروب الشمس لتجنب ذروة الحرارة خلال فترة الظهيرة.',style: TextStyle(fontSize: 20,height: 1.2),),
                  ),


                  Text('فصل الخريف ',textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 32,
                  ),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 360,
                    height: 215,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/about_yemen/autumn.png',fit: BoxFit.cover,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 12,top: 12),
                    child: Text('الخريف هو فصل رائع لزيارة اليمن، حيث تبدأ درجات الحرارة في الانخفاض تدريجيًا، مما يجعل الجو أكثر راحة. هذا الوقت من السنة مثالي لزيارة المناطق الساحلية والجبلية على حد سواء، حيث يمكن الاستمتاع بالمناظر الطبيعية الخلابة والأجواء المعتدلة في إب و قرى صنعاء. الأشجار تبدأ بتغيير لون أوراقها في بعض المناطق، مما يضيف لمسة جمالية إضافية. في هذا الفصل، يمكن أيضًا الاستمتاع بزيارة الأسواق المحلية والاستمتاع بالمأكولات اليمنية الشهية.',style: TextStyle(fontSize: 20,height: 1.2),),
                  ),


                  Text('فصل الربيع ',textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 32,
                  ),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 360,
                    height: 215,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/about_yemen/spring.png',fit: BoxFit.cover,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 12,top: 12),
                    child: Text('يعتبر الربيع من أفضل الفصول لزيارة اليمن، حيث يتميز بطقس معتدل وأجواء مريحة تجعل من استكشاف المدن والمعالم السياحية تجربة ممتعة. في هذا الوقت من السنة، تزدهر الطبيعة وتكتسي الأرض بألوان زاهية من الأزهار والنباتات، مما يجعل الرحلات والتنزه في الريف والحدائق نشاطًا رائعًا. بالإضافة إلى ذلك، فإن العديد من الفعاليات والمهرجانات المحلية تقام خلال فصل الربيع، مما يمنح الزوار فرصة للتعرف على الثقافة اليمنية التقليدية.حيث يمكنك زيارة صنعاء القديمة لاستكشاف الشوارع الضيقة و المباني القديمة , جبال حراز التي تعتبر مثالية للرحلات والتنزه و أيضاً وادي حضرموت يمكن زيارة القرى التقليدية واكتشاف تاريخ حضرموت العريق.',style: TextStyle(fontSize: 20,height: 1.2),),
                  ),



                  Text('فصل الشتاء ',textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 32,
                  ),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 360,
                    height: 215,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/about_yemen/winter.png',fit: BoxFit.cover,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 12,top: 12),
                    child: Text('الشتاء في اليمن يتميز بطقس بارد نسبياً في المناطق الجبلية مثل   ، حيث يمكن أن تنخفض درجات الحرارة بشكل ملحوظ، مما يجعلها فترة مثالية للأنشطة الداخلية وزيارة المتاحف والأسواق. في المقابل، المناطق الساحلية تكون أكثر دفئًا ومناسبة للأنشطة الخارجية والمشي على الشواطئ. هذا الفصل يشهد أيضًا الليالي الطويلة والأيام القصيرة، مما يوفر فرصة للاستمتاع بالدفء في المقاهي والمطاعم التقليدية وتذوق الأطباق اليمنية الدافئة.',style: TextStyle(fontSize: 20,height: 1.2),),
                  ),

                  Text('طريقة الحصول على شريحة SIM ',style: TextStyle(
                    fontSize: 24,
                    color: Color(0xffa76f47),
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 12),
                    child: Text('يمكن الحصول على الشريحة من متاجر مزدوي شبكات الهاتف المحمول و الوكلاء المعتمدين . ',style: TextStyle(fontSize: 20,height: 1.2),),
                  ),
                  Text('شركات الأتصالات ',style: TextStyle(
                    fontSize: 24,
                    color: Color(0xffa76f47),
                  ),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 157,
                          height: 129,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset('assets/images/about_yemen/1.png',fit: BoxFit.cover,)
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 157,
                          height: 129,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset('assets/images/about_yemen/2.png',fit: BoxFit.cover,)
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 157,
                          height: 129,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset('assets/images/about_yemen/3.png',fit: BoxFit.cover,)
                          ),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                  )












                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

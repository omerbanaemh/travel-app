import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutYemenPage extends StatelessWidget {
  const AboutYemenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children:[ SizedBox(
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
            SizedBox(
                width: double.infinity,
                child: Image.asset('assets/images/home/underbanner.png',fit: BoxFit.cover,)
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0,left: 8,bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text('عن اليمن',style: TextStyle(fontSize: 32,color: Color(
                      0xffa76f47)),),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 12),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: 'الجمهورية اليمنية، ',),
                          TextSpan(text: 'موقعها ',style: TextStyle(color: Color(0xffa76f47),fontSize: 24),),
                          TextSpan(text: 'في جنوب غرب شبه الجزيرة العربية ويطل على بحر العرب والبحر الأحمر .'),
                          TextSpan(text: 'عاصمة اليمن ',style: TextStyle(color: Color(0xffa76f47),fontSize: 24),),
                          TextSpan(text: 'صنعاء , و '),
                          TextSpan(text: 'عاصمتها الأقتصادية ',style: TextStyle(color: Color(0xffa76f47),fontSize: 24),),
                          TextSpan(text: 'عدن . '),
                          TextSpan(text: 'تاريخيًا',style: TextStyle(color: Color(0xffa76f47),fontSize: 24),),
                          TextSpan(text: '، يعتبر اليمن من أقدم المراكز الحضارية في العالم مع ممالك قديمة مثل سبأ ومعين. يتميز بتضاريس متنوعة تشمل الجبال، السهول الساحلية، والصحاري، ومناخه يختلف من منطقة لأخرى.'),
                          TextSpan(text: 'الثقافة اليمنية ',style: TextStyle(color: Color(0xffa76f47),fontSize: 24),),
                          TextSpan(text: 'غنية بالتقاليد، مثل رقصات البرع و الشرح ، واحتساء القهوة اليمنية. '),
                          TextSpan(text: 'الاقتصاد ',style: TextStyle(color: Color(0xffa76f47),fontSize: 24),),
                          TextSpan(text: 'يعتمد بشكل كبير على الزراعة والنفط.'),
                        ],
                      ),
                    ),
                  ),
                  const Text('الثقافة',style: TextStyle(fontSize: 32,color: Color(
                      0xffa76f47)),),
                  const Padding(
                    padding: EdgeInsets.only(right: 12, bottom: 12),
                    child: Text('تعد اليمن غنية بالثقافة والتراث التقليدي. الملابس التقليدية، الأغاني الشعبية، والرقصات التراثية مثل "البرعة" هي جزء لا يتجزأ من الحياة اليومية.القهوة اليمنية تعتبر جزءًا من التقاليد الاجتماعية.',style: TextStyle(fontSize: 20,height: 1.2),),
                  ),

                  const Text('الدين',style: TextStyle(fontSize: 32,color: Color(
                      0xffa76f47)),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 360,
                    height: 215,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/about_yemen/religion.png',fit: BoxFit.cover,)
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 12,top: 12, bottom: 12),
                    child: Text('الغالبية العظمى من السكان يعتنقون الإسلام، وهناك أيضًا أقلية صغيرة من الديانات الأخرى مثل اليهودية و المسيحية.',style: TextStyle(fontSize: 20,height: 1.2),),
                  ),


                  const Text('اللغة',style: TextStyle(fontSize: 32,color: Color(
                      0xffa76f47)),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 360,
                    height: 215,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/about_yemen/language.png',fit: BoxFit.cover,)
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 12,top: 12, bottom: 12),
                    child: Text('اللغة العربية هي اللغة الرسمية . ولكن تتميز اليمن بكثرة اللهجات المختلفة فيها حسب كل منطقة و أخرى مثل :اللهجة الصنعانية , اللهجة الحضرمية , اللهجة التعزية و العدنية .اللغات الأخرى: في جزيرة سقطرى، يتحدث السكان لغة السقطرية، وهي لغة سامية قديمة تختلف عن العربية.',style: TextStyle(fontSize: 20,height: 1.2),),
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

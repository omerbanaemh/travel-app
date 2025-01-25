import 'package:flutter/material.dart';

class AboutYemenPage extends StatelessWidget {
  const AboutYemenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 230,
                width: double.infinity,
                child: Image.asset('assets/images/about_yemen/group.png',fit: BoxFit.cover,)
            ),
            Container(
                width: double.infinity,
                child: Image.asset('assets/images/home/underbanner.png',fit: BoxFit.cover,)
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text('عن اليمن',style: TextStyle(fontSize: 32,color: Color(
                  0xffa76f47)),),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35.0, left: 4),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Tajawal'
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
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text('الدين',style: TextStyle(fontSize: 32,color: Color(
                  0xffa76f47)),),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8.0,bottom: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 157,
                    height: 129,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/about_yemen/religion.png',fit: BoxFit.cover,)
                    ),
                  ),
                ),
                Expanded(
                  child: Text('الغالبية العظمى من السكان يعتنقون الإسلام، وهناك أيضًا أقلية صغيرة من الديانات الأخرى مثل اليهودية و المسيحية.',style: TextStyle(fontSize: 20,fontFamily: 'Tajawal',height: 1.2),),
                ),
              ],
            ),


            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text('اللغة',style: TextStyle(fontSize: 32,color: Color(
                  0xffa76f47)),),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8.0,bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.grey),
                    ),
                    width: 157,
                    height: 129,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/images/about_yemen/language.png',fit: BoxFit.cover,)
                    ),
                  ),
                ),
                Expanded(
                  child: Text('اللغة العربية هي اللغة الرسمية . ولكن تتميز اليمن بكثرة اللهجات المختلفة فيها حسب كل منطقة و أخرى مثل : اللهجة الصنعانية , اللهجة الحضرمية , اللهجة التعزية و العدنية .',style: TextStyle(fontSize: 20,fontFamily: 'Tajawal',height: 1.2),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

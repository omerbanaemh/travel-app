import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/views/screens/login/login.dart';

// شاشة المقدمة (intro) تظهر عند أول تشغيل للتطبيق
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // الانتقال للصفحة التالية أو شاشة تسجيل الدخول عند الانتهاء
  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          // عرض الشرائح باستخدام PageView لثلاث شاشات ترحيبية
          PageView(
          reverse: true,
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            // الشريحة الأولى
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Flexible( flex: 1,
                      child: SizedBox(height: 120,)),
                  const Flexible( flex: 1,
                      child: SizedBox(height: 100,)),
                  Flexible(
                      flex: 2,
                      child: Image.asset('assets/images/introduction_screen/1.png')),
                  const Text(
                    'خطط\nلرحلتك القادمة معنا',
                    style: TextStyle(fontSize: 34, color: Color(0xFFCE9263)),
                    textAlign: TextAlign.center,
                  ),
                  const Flexible( flex: 1,
                    child: Text(
                      'سهلنا لك التخطيط فقط سارع بالحجز اختر وجهتك واستعد لمغامرة لا تُنسى في أجمل مواقع اليمن. نحن هنا لجعل رحلتك تجربة مميزة مليئة بالذكريات',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Flexible(
                      child: SizedBox(height: 50,)),
                ],
              ),
            ),
            // الشريحة الثانية
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Flexible( flex: 1,
                      child: SizedBox(height: 120,)),
                  const Flexible( flex: 1,
                      child: SizedBox(height: 120,)),
                  const Flexible(flex:1,
                    child: Center(
                      child: Text(
                        'معالم يمنية لا تفوّت',
                        style: TextStyle(fontSize: 34, color: Color(0xFFCE9263)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Flexible(flex:1,
                    child: Center(
                      child: Text(
                        'اكتشف أفضل الوجهات السياحية في اليمن من المواقع التاريخية إلى المناظر الطبيعية الخلابة ، نأخذك في جولة فريدة لتجربة ما يميز هذا البلد الساحر',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Image.asset(
                      'assets/images/introduction_screen/2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Flexible(
                      flex:1,
                      child: SizedBox(height: 120)),
                ],
              ),
            ),
            // الشريحة الثالثة
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Flexible( flex: 1,
                      child: SizedBox(height: 120,)),
                  const Flexible( flex: 1,
                      child: SizedBox(height: 120,)),
                  Flexible( flex: 2,
                      child: Image.asset('assets/images/introduction_screen/3.png')),
                  const Flexible(
                    child: Text(
                      'أستكشف جمال اليمن معنـــــــــــــــــا',
                      style: TextStyle(fontSize: 34, color: Color(0xFFCE9263)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Flexible(
                    child: Text(
                      'انغمس في سحر اليمن مع جولاتنا الفريدة، وتعرّف على روح الضيافة اليمنية.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Flexible(
                      child: SizedBox(height: 150,)),

                ],
              ),
            ),
          ],
        ),
          // زر "التالي" أسفل الصفحة
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              color: Colors.transparent,
              child: InkWell(
                onTap: _nextPage,
                child: SvgPicture.asset(
                  'assets/images/introduction_screen/next.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),)
  ]
      ),
    );
  }

}

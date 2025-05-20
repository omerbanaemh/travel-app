import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yemen_travel_guid/loading.dart';
import 'package:yemen_travel_guid/views/screens/login/splash.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yemen travel guid',
      // إعداد الثيم العام للتطبيق
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white
        ),
        fontFamily: 'Tajawal',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F3F40)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // دعم اللغة العربية فقط حالياً
      supportedLocales: const [
        Locale('ar',''),
      ],
      // الشاشة الأولى التي تظهر عند تشغيل التطبيق
      home: const Loading(),
    );
  }
}

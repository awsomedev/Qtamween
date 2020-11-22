import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qtameen/Screens/HomeScreen.dart';
import 'package:qtameen/Screens/splashScreen.dart';
import 'package:qtameen/api/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
      path: 'local', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
        locale: Locale(context.locale.languageCode),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              textTheme: Theme.of(context).textTheme.copyWith(
                  title: TextStyle(color: Colors.white, fontSize: 20))),
          primaryColor: Color(0xff4fc2f8),
          fontFamily: GoogleFonts.roboto().toString(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      // width: 100,
      // color: Colors.green,
      child: Image.asset(
        'images/bg.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

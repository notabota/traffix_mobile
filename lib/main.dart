import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traffix/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:traffix/pages/map.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:traffix/pages/roads/state/homepage_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePageStateProvider())
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              theme: ThemeData(
                // fontFamily: 'K2D',
                pageTransitionsTheme: const PageTransitionsTheme(builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                }),
                // primaryColor: Kcolors.primary,
                // primaryColorDark: Kcolors.primaryDark,
                // primarySwatch: Colors.deepOrange,
                // primaryColor: Colors.black,
                // brightness: Brightness.dark,
                // accentColor: Colors.black,
                // canvasColor: Colors.white12,
                primaryColor: Colors.white,
                brightness: Brightness.light,
                colorScheme:
                    ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
              ),
              debugShowCheckedModeBanner: false,
              title: 'TheGorgeousLogin',
              home: home(),
            );
          }),
    );
  }

  Widget home() {
    //   final user = FirebaseAuth.instance.currentUser;
    //   if (user == null) {
    //     return const LoginPage();
    //   } else {
    //     return const MapPage();
    //   }
    return const MapPage();
  }
}

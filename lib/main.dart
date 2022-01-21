import 'package:chatnest/binding/init_binding.dart';
import 'package:chatnest/routes/app_page.dart';
import 'package:chatnest/service/authService.dart';
import 'package:chatnest/service/chatService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");

  const bool version = true;

  await initService();
  await Future.delayed(Duration(seconds: 2));
  runApp(MyApp(
    version: version,
  ));
}

Future<void> initService() async {
  // Auth Service
  await Get.putAsync(() async => await AuthService());
  await Get.putAsync(() async => await ChatService());
}

class MyApp extends StatefulWidget {
  final bool? version;
  const MyApp({@required this.version});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => GetMaterialApp(
        initialBinding: InitBinding(),
        locale: Locale('ko', 'KR'), // 해당 지역의 번역이 표시
        fallbackLocale: Locale('ko', 'KR'),
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
        theme: ThemeData(
          appBarTheme: AppBarTheme(brightness: Brightness.dark),
          scaffoldBackgroundColor: Colors.black,
          // fontFamily: "NotoSansKR",
        ),
        builder: (context, widget) {
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget ?? Container(),
          );
        },
        // initialBinding: InitBinding(),
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        getPages: AppPages.routes,
      ),
    );
  }
}

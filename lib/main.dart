import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/services/prefs.dart';
import 'package:sansgen/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'keys/assets_images.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefService prefService = PrefService();

  await dotenv.load(fileName: ".env");
  // String initialRoutes = Routes.DETAIL;
  await prefService.prefInit();
  String isToken = prefService.getUserToken ?? '';
  bool isOnBoarding = prefService.getOnBoarding ?? false;
  log(isToken, name: 'token login');
  String onBoarding =
      isOnBoarding == false ? Routes.ON_BOARDING : Routes.DASHBOARD;
  String initialRoutes = isToken == '' ? Routes.LOGIN : onBoarding;
  // runApp(MyApp(initialRoutes));
  runApp(FutureBuilder(
    future: Future.delayed(const Duration(seconds: 3)),
    builder: (context, s) {
      if (s.connectionState == ConnectionState.waiting) {
        return const MaterialApp(
          title: "Sansgen",
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      } else {
        return MyApp(initialRoutes);
      }
    },
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoutes;

  const MyApp(
    this.initialRoutes, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sansgen',
      // debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      getPages: AppPages.routes,
      initialRoute: initialRoutes,
      builder: EasyLoading.init(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KeysAssetsImages.splashScreen,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

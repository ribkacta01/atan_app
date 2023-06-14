import 'package:atan_app/app/util/Error_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import 'app/controller/auth_controller.dart';
import 'app/controller/fcm_controller.dart';
import 'app/modules/splash_screen/views/splash_screen_view.dart';
import 'app/routes/app_pages.dart';
import 'app/util/Loading.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDateFormatting('id_ID', null)
      .then((value) => runApp(AtanApp()));
}

class AtanApp extends StatelessWidget {
  final FCMController fcmController = FCMController();
  //const AtanApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final authC = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snap) {
          if (snap.hasError) {
            return Error_page();
          }
          if (snap.connectionState == ConnectionState.done) {
            return Sizer(builder: (context, orientation, deviceType) {
              return FutureBuilder(
                  future: Future.delayed(Duration(seconds: 2)),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.done) {
                      return AnnotatedRegion(
                          value: SystemUiOverlayStyle(
                              statusBarIconBrightness: Brightness.dark,
                              statusBarColor: Colors.white),
                          child: Obx(
                            () => GetMaterialApp(
                              title: "Atan App",
                              debugShowCheckedModeBanner: false,
                              initialRoute: authC.isAuth.isTrue
                                  ? Routes.HOME
                                  : Routes.LOGIN,
                              getPages: AppPages.routes,
                              initialBinding: BindingsBuilder(() {
                                Get.put(fcmController);
                              }),
                            ),
                          ));
                    } else {
                      return FutureBuilder(
                          future: authC.firstInitialized(),
                          builder: (context, snap) {
                            return SplashScreenView();
                          });
                    }
                  });
            });
          }
          return const Loading();
        });
  }
}

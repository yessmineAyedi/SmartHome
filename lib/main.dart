import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turkeysh_smart_home/core/resource/app_bindings.dart';
import 'package:turkeysh_smart_home/core/resource/connection/websocket_service.dart';

import 'core/constants/routes.dart';
import 'core/constants/utils.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppBindings().dependencies();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: PagesRoutes.splash,
      // initialRoute: GetStorage().read(AppUtils.userTokenAccess) != null
      //     ? PagesRoutes.project
      //     : PagesRoutes.login,
      locale: const Locale('fa'),
      getPages: PagesRoutes.pages,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      theme: ThemeData(
        fontFamily: 'IranSans',
        useMaterial3: true
      ),
    );
  }
}



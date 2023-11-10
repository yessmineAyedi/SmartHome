import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turkeysh_smart_home/core/constants/routes.dart';
import 'package:turkeysh_smart_home/core/widget/oval_right_border_clipper.dart';
import 'dart:math' as math;

import '../constants/images.dart';
import 'drawer_item_list.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ClipPath(
      clipper: OvalRightBorderClipper(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0),
          decoration: BoxDecoration(
            color: Get.theme.bottomAppBarColor,
          ),
          width: 300,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,

                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: Get.theme.primaryColor,
                    ),
                    onPressed: () {
                      // scaffoldKey.currentState!.openEndDrawer();
                    },
                  ),
                ),
                Container(
                  height: 90,
                  width: 90,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    //shape: BoxShape.circle,
                    //border: Border.all(width: 2, color: Colors.orange),
                    image: DecorationImage(image: AssetImage(Images.logo)),
                  ),
                ),
                const SizedBox(height: 5.0),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        left:  0,
                        right: null,
                        bottom: 00,
                        child: Transform(
                          alignment: Alignment.center,
                          transform:
                              Matrix4.rotationY(0),
                          child: Container(
                            height: 500,
                            width: 500,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Get.isDarkMode
                                      ? Images.logoDark
                                      : Images.logo),
                                  fit: BoxFit.cover,
                                  opacity: 0.05),
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Divider(),
                            const SizedBox(height: 15,),
                            drawerItemList(
                                icon: const Icon(Icons.language),
                                title: 'زبان',
                                onTap: () {
                                 // Get.toNamed(
                                     // RouteHelper.getLanguageRoute('menu'));
                                }),
                            const SizedBox(height: 15,),
                            const Divider(),
                            const SizedBox(height: 15,),
                            drawerItemList(
                                icon: const Icon(Icons.settings),
                                title: 'تنظیمات',
                                onTap: () {
                                  //Get.toNamed(RouteHelper.getSettingRoute());
                                }),
                            const SizedBox(height: 15,),
                            const Divider(),
                            const SizedBox(height: 15,),
                            drawerItemList(
                                icon: const Icon(Icons.developer_board),
                                title: 'تنظیمات بردها',
                                onTap: () {
                                  Get.toNamed(PagesRoutes.boardSetting);
                                }),
                            const SizedBox(height: 15,),
                            const Divider(),
                            const SizedBox(height: 15,),
                            drawerItemList(
                                icon: const Icon(Icons.info),
                                title: 'در مورد ما',
                                onTap: () {
                                  //Todo Page about us...
                                }),
                            const SizedBox(height: 15,),
                            const Divider(),
                            const SizedBox(height: 15,),
                            drawerItemList(
                                icon: const Icon(Icons.shopping_bag),
                                title: 'فروشگاه',
                                onTap: () {
                                  //Todo Page store WebView
                                }),
                            const SizedBox(height: 15,),
                            const Divider(),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
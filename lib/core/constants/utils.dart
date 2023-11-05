import 'package:flutter/material.dart';

import '../../features/home/presentation/screen/home_page.dart';
import '../../test.dart';

class AppUtils{
  static const String userTokenAccess = 'UserTokenAccess';
  static const String userTokenRefresh = 'UserTokenRefresh';

  static List<IconData> iconList = <IconData>[
    Icons.home,
    Icons.access_time_rounded,
    Icons.control_point_duplicate_sharp,
    Icons.menu,
  ];

  static List<Widget> pages = [
    HomePage(),
    Test2(),
    Test3(),
    Test4(),
  ];

  static List<String> navTitle = [
    'خانه',
    'سناریو',
    'شرایط خاص',
    '',
  ];


  static Map<String, String> deviceInfo = {
    'کلید سه تایمر': 'این دسته شامل وسایلی است که تنها دو حالت میگیرند و میتوان سه زمان روشن شدن برای آن ها در نظر گرفت.',
    'کلید تک تایمر':'این دسته شامل وسایلی است که تنها دو حالت میگیرند و میتوان یک زمان روشن شدن برای آن ها در نظر گرفت.',
    'سنسور دما':'در این دسته هر سنسور درصورت درخواست شما نشان دهنده ی دمای دریافتی است',
    'سنسور گاز':'در این دسته هر سنسور درصورت درخواست شما نشان دهنده ی میزان گاز دریافتی است',
    'سنسور رطوبت':'در این دسته هر سنسور درصورت درخواست شما نشان دهنده ی رطوبت دریافتی از محیط است',
    'سنسور خاک':'در این دسته هر سنسور درصورت درخواست شما نشان دهنده ی این است که خاک رطوبت مناسبی دارد یا خیر',
    'چشمی ها و سنسور تشخیص حرکت':'این دسته شامل چشمی ها و سنسور حرکت است که شما میتوانید در صورت نیاز آن هارا خاموش یا روشن نمایید',
    'دیمر ها':'این دسته شامل دیمر هاست که در آن تمام دیمر ها نشان داده شده است و شما میتوانید آنهارا خاموش یا رونش نموده و یا میزان آن را تنظیم نمایید.',

  };
}
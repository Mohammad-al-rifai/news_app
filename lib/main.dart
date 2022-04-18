import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl/layout/shop_app/cubit/cubit.dart';
import 'package:pl/layout/shop_app/shop_layout.dart';
import 'package:pl/modules/shop_app/login/shop_login_screen.dart';
import 'package:pl/modules/shop_app/new_product/ImagePickerScreen.dart';
import 'package:pl/modules/shop_app/new_product/new_product_screen.dart';
import 'package:pl/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:pl/shared/bloc_observer.dart';
import 'package:pl/shared/components/constants.dart';
import 'package:pl/shared/cubit/cubit.dart';
import 'package:pl/shared/cubit/states.dart';
import 'package:pl/shared/network/local/cache_helper.dart';
import 'package:pl/shared/network/remote/dio_helper.dart';
import 'package:pl/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  List<Map<dynamic,dynamic>> dis = [
    {
      "date":"2021-12-30",
      "discount_percentage":"50"
    },
    {
      "date":"2021-12-30",
      "discount_percentage":"50"
    }
  ];

  Map<dynamic,dynamic> dis1 = {
    'id':1,
    'list':dis
  };
print('here is list');
  print(dis1['list']);

  Widget widget;

  bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  userId = CacheHelper.getData(key: 'userId');

  print("*************");
  print(token);
  print("USERID :$userId");
  print("*************");


  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
      // widget = ImagePickerScreen();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()..getMyPostsData(userId)
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
            // home: ImagePickerScreen(),
          );
        },
      ),
    );
  }
}


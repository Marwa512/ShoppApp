// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_null_comparison, unnecessary_null_in_if_null_operators, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/shop_layout/cubit/cubit.dart';
import 'package:flutter_application_3/layout/shop_layout/shoplayout.dart';
import 'package:flutter_application_3/module/ShopApp/register/cubit/cubit.dart';
import 'package:flutter_application_3/module/ShopApp/search/cubit/cubit.dart';
import 'package:flutter_application_3/shared/bloc_observer.dart';
import 'package:flutter_application_3/shared/component/component/constant/constant.dart';
import 'package:flutter_application_3/shared/network/local/cache_helper.dart';
import 'package:flutter_application_3/shared/network/remote/dio_helper.dart';

import 'package:flutter_application_3/shared/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'module/ShopApp/login/cubit/cubit.dart';
import 'module/ShopApp/login/login_screen.dart';
import 'module/ShopApp/onBoarding/onBoarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await cachHelper.init();

  bool onBoarding = cachHelper.GetData(key: 'onBoarding') ?? false;
  token = cachHelper.GetData(key: 'token') ?? '';
  print(token);
  Widget Home;

   if (onBoarding) {
    if (token.isEmpty) {
      Home = LoginScreen();
    } else {
      Home = ShopLayout();
    }
  } else {
    if (token.isEmpty) {
      Home = LoginScreen();
    } else {
      Home = ShopLayout();
    }
  }
  runApp(MyApp(Home));
}

class MyApp extends StatelessWidget {
  final Home;
  MyApp(this.Home);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => ShopCubit()
                ..getHomeData()
                ..getCategoriesData()
                ..getCFavData()
                ..getUserData()
                ..getCartData()),
          BlocProvider(create: (BuildContext context) => ShopLoginCubit()),
          BlocProvider(create: (BuildContext context) => ShopRegisterCubit()),
          BlocProvider(create: (BuildContext context) => ShopSearchCubit()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: Home,
        ));
  }
}

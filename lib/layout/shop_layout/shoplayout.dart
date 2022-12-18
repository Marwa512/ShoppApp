// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/shop_layout/cubit/cubit.dart';
import 'package:flutter_application_3/layout/shop_layout/cubit/states.dart';
import 'package:flutter_application_3/module/ShopApp/login/login_screen.dart';
import 'package:flutter_application_3/shared/component/component/reusablecomponent.dart';
import 'package:flutter_application_3/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../module/ShopApp/cart/cart_screen.dart';
import '../../module/ShopApp/search/SearchScreen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Shopping Zone"),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                onPressed: () {
                  navigateTo(context, CartScreen());
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 25,
                  // color: Colors.white,
                ),
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.BottomNavBar(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Product'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Setting'),
              ]),
        );
      },
    );
  }
}

// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/newsApp/cubit/cubit.dart';
import 'package:flutter_application_3/layout/newsApp/cubit/newsState.dart';
import 'package:flutter_application_3/module/business/businessScreen.dart';
import 'package:flutter_application_3/module/search_module/search.dart';
import 'package:flutter_application_3/shared/component/component/reusablecomponent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class newsAppLayout extends StatelessWidget {
  const newsAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => newsAppCubit()..getBusinessData(),
        child: BlocConsumer<newsAppCubit, newsAppState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = newsAppCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("News App"),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                navigateTo(context, SearchScreen());
                              },
                              icon: Icon(
                                Icons.search,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              onPressed: () {
                                newsAppCubit.get(context).appThemeChange();
                                print("${newsAppCubit.get(context).isDark}");
                              },
                              icon: Icon(
                                Icons.brightness_4_outlined,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                bottomNavigationBar: BottomNavigationBar(
                  items: cubit.bottomItem,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) => cubit.BottomNavBar(index),
                ),
                body: cubit.Screens[cubit.currentIndex],
              );
            }));
  }
}

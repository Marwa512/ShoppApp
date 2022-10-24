// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/newsApp/cubit/cubit.dart';
import 'package:flutter_application_3/layout/newsApp/cubit/newsState.dart';
import 'package:flutter_application_3/shared/component/component/reusablecomponent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => newsAppCubit(),
      child: BlocConsumer<newsAppCubit, newsAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = newsAppCubit.get(context).search;

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: searchController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'search cant be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      newsAppCubit.get(context).searchData(key: value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: articleBuilder(list, isSearch: true))
              ],
            ),
          );
        },
      ),
    );
  }
}

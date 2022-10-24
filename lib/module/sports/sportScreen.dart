// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/newsApp/cubit/cubit.dart';
import '../../layout/newsApp/cubit/newsState.dart';
import '../../shared/component/component/reusablecomponent.dart';

class sportsScreen extends StatelessWidget {
  const sportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsAppCubit, newsAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = newsAppCubit.get(context).sports;
          return articleBuilder(list);
        });
  }
}

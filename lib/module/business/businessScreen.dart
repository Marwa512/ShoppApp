// ignore_for_file: camel_case_types, prefer_const_constructors, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/newsApp/cubit/cubit.dart';
import 'package:flutter_application_3/layout/newsApp/cubit/newsState.dart';
import 'package:flutter_application_3/shared/component/component/reusablecomponent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class businessScreen extends StatelessWidget {
  const businessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsAppCubit, newsAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = newsAppCubit.get(context).business;
          return articleBuilder(list);
        });
  }
}

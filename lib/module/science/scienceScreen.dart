// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/newsApp/cubit/newsState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/newsApp/cubit/cubit.dart';
import '../../shared/component/component/reusablecomponent.dart';

class scienceScreen extends StatelessWidget {
  const scienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsAppCubit, newsAppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = newsAppCubit.get(context).science;
          return articleBuilder(list);
        });
  }
}

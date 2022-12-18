// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/shop_layout/cubit/cubit.dart';
import 'package:flutter_application_3/layout/shop_layout/cubit/states.dart';
import 'package:flutter_application_3/module/ShopApp/login/login_screen.dart';
import 'package:flutter_application_3/shared/component/component/reusablecomponent.dart';
import 'package:flutter_application_3/shared/network/local/cache_helper.dart';
import 'package:flutter_application_3/shared/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        emailController.text = model!.data!.email!;
        nameController.text = model.data!.name!;
        phoneController.text = model.data!.phone!;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is ShopLoadingUpdateUserDataState)
                    LinearProgressIndicator(),
                  /* Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Image(
                            image: NetworkImage('${model.data!.image!}'),
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 60,
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Colors.grey[200],
                          ),
                        )
                      ]),
                       */

                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: ((String? value) {
                      if (value!.isEmpty) {
                        return ("Name cant be empty");
                      }
                    }),
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,

                    //  obscureText: loginCubit.isPasswordShown,
                    validator: ((String? value) {
                      if (value!.isEmpty) {
                        return ("Email Cant be empty");
                      }
                    }),

                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: ((String? value) {
                      if (value!.isEmpty) {
                        return ("Phone Cant be empty");
                      }
                    }),
                    decoration: InputDecoration(
                      labelText: "Phone",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                              email: emailController.text,
                              name: nameController.text,
                              phone: phoneController.text);
                        }
                      },
                      child: Text(
                        "UPDATE",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        cachHelper.DeleteItem(key: 'token');
                        navigateAndFinish(context, LoginScreen());
                      },
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

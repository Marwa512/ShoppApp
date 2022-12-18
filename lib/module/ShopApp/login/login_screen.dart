// ignore_for_file: prefer_const_constructors, unnecessary_string_escapes, prefer_const_literals_to_create_immutables, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/shop_layout/shoplayout.dart';
import 'package:flutter_application_3/module/ShopApp/login/cubit/cubit.dart';
import 'package:flutter_application_3/module/ShopApp/login/cubit/states.dart';
import 'package:flutter_application_3/module/ShopApp/register/register_screen.dart';

import 'package:flutter_application_3/shared/component/component/reusablecomponent.dart';
import 'package:flutter_application_3/shared/network/local/cache_helper.dart';
import 'package:flutter_application_3/shared/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, shopLoginStates>(
      listener: (context, state) {
        if (state is ShopLoginSucessState) {
          if (state.loginModel.status) {
            print(state.loginModel.message);
            print(state.loginModel.data!.token);
            cachHelper.SaveData(
                key: 'token', value: state.loginModel.data!.token);
            Fluttertoast.showToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            navigateAndFinish(
              context,
              ShopLayout(),
            );
          } else {
            print(state.loginModel.message);
            Fluttertoast.showToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        var loginCubit = ShopLoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "Login now to browse our offers ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: ((String? value) {
                          if (value!.isEmpty) {
                            return ("Email cant be empty");
                          }
                        }),
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: loginCubit.isPasswordShown,
                        validator: ((String? value) {
                          if (value!.isEmpty) {
                            return ("password is too short");
                          }
                        }),
                        onFieldSubmitted: (value) {
                          if (formkey.currentState!.validate()) {
                            loginCubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginCubit.changePasswordVisibility();
                              },
                              icon: Icon(
                                loginCubit.suffix,
                              ),
                            )),
                      ),
                      SizedBox(height: 40),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              print("Login pressed");
                              if (formkey.currentState!.validate()) {
                                loginCubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        fallback: (Context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don\'t have account?",
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, ShopRegisterScreen());
                            },
                            child: Text("REGISTER"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

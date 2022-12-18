// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, curly_braces_in_flow_control_structures, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_3/shared/network/local/cache_helper.dart';
import 'package:flutter_application_3/shared/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/component/component/reusablecomponent.dart';
import '../login/login_screen.dart';
import 'package:flutter_application_3/main.dart';

class onBoardingModel {
  final String image;
  final String title;
  final String body;
  onBoardingModel(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<onBoardingModel> onBoarding = [
    onBoardingModel('assets/img/Online Groceries-cuate.png', ' Select Goods ',
        'wide selection of products'),
    onBoardingModel('assets/img/Online wishes list-bro.png', ' Add to Basket ',
        'Easy to buy and quick delivery'),
    onBoardingModel('assets/img/In no time-amico.png', ' SHOPPING ZONE',
        'Save you money and time'),
  ];

  bool isLast = false;

  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                "SKIP",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  // physics: BouncingScrollPhysics(),
                  onPageChanged: (i) {
                    if (i == (onBoarding.length - 1) && !isLast)
                      setState(() => isLast = true);
                    else if (isLast) setState(() => isLast = false);
                  },
                  itemBuilder: (context, index) =>
                      onBoardingItem(onBoarding[index]),
                  itemCount: onBoarding.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: onBoarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ]),
            ],
          ),
        ));
  }

  Widget onBoardingItem(onBoardingModel Boarding) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: Image(
          image: AssetImage(
            '${Boarding.image}',
          ),
        )),
        SizedBox(
          height: 30,
        ),
        Text(
          '${Boarding.title}',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${Boarding.body}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ]);

  Future<void> submit() async {
    setState(() {
      cachHelper.SaveData(key: 'onBoarding', value: true);

      print(cachHelper.GetData(key: 'onBoarding'));
    });
    navigateAndFinish(
      context,
      LoginScreen(),
    );
  }
}

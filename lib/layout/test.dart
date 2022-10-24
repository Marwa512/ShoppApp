// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Center(
        child: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.showBottomSheet(
                (context) => Column(mainAxisSize: MainAxisSize.min, children: [
                      TextFormField(
                        controller: titleController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            print("title cant be empty");
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "title",
                          prefixIcon: Icon(Icons.abc),
                          border: OutlineInputBorder(),
                        ),
                      )
                    ]));
            /* scaffoldKey.currentState?.showBottomSheet((context) => Container(
                  color: Colors.amber,
                  height: 100,
                  width: double.infinity,
                )); */
          },
          icon: Icon(Icons.abc),
          iconSize: 50,
        ),
      ),
    );
  }
}

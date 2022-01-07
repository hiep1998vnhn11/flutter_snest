import 'package:flutter/material.dart';
import 'package:snest/store/auth.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Image(
                      image: AssetImage('images/facebook.png'),
                      width: 40,
                    )
                  ],
                ),
                Row(
                  children: [
                    Material(
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Icon(Icons.message),
                        color: Colors.red,
                      ),
                    )
                  ],
                )
              ],
            )),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.red,
                width: 3000,
                child: Obx(() => Text("${authController.count}")),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
              ),
            ),
          ],
        ));
  }
}

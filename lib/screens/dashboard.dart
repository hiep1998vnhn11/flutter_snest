import 'package:flutter/material.dart';
import 'package:snest/store/auth.dart';
import 'package:get/get.dart';
import 'package:snest/widgets/post_item.dart';
import 'package:snest/util/data.dart';

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
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            Map post = posts[index];
            return PostItem(
                img: post['img'],
                name: post['name'],
                dp: post['dp'],
                time: post['time']);
          },
        ));
  }
}

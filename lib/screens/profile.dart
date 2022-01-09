import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snest/util/data.dart';
import 'package:get/get.dart';
import 'package:snest/store/auth.dart';
import 'package:snest/util/http.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> user = {};
  final AuthController authController = Get.find();
  static Random random = Random();
  @override
  Widget build(BuildContext context) {
    Future<void> _getUserInfo() async {
      try {
        final String url = '/v1/user/${widget.id}/get_info';
        final Map<String, dynamic> info = await HttpService.get(url);
        print(info);
        print('123');
        setState(() {
          user = {};
        });
      } catch (e) {
        print(e);
      }
    }

    if (mounted) {
      _getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        toolbarHeight: 45,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              CircleAvatar(
                backgroundImage: AssetImage(
                  "images/cm${random.nextInt(10)}.jpeg",
                ),
                radius: 50,
              ),
              const SizedBox(height: 10),
              Text(
                '${user['user']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                "Status should be here",
                style: TextStyle(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextButton(
                    child: const Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildCategory("Posts"),
                    _buildCategory("Friends"),
                    _buildCategory("Groups"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.all(2),
                itemCount: 35,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      "images/cm${random.nextInt(10)}.jpeg",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String title) {
    return Column(
      children: <Widget>[
        Text(
          random.nextInt(10000).toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(),
        ),
      ],
    );
  }
}

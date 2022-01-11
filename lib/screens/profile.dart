import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snest/util/data.dart';
import 'package:get/get.dart';
import 'package:snest/store/auth.dart';
import 'package:snest/util/http.dart';
import 'package:snest/util/router.dart';

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

  Future<void> _getUserInfo() async {
    try {
      final String url = '/v1/user/${widget.id}/get_info';
      final Map<String, dynamic> info = await HttpService.get(url);
      setState(() {
        user = info;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user['full_name'] ?? 'Người dùng Snest',
          style: const TextStyle(fontSize: 18),
        ),
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
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      image: user['info']?['profile_background_path'] != null
                          ? DecorationImage(
                              image: NetworkImage(
                                  user['info']['profile_background_path']),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage(
                                'images/background-default.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      height: 35,
                      width: 35,
                      child: const Center(
                        child: SizedBox(
                          child: Icon(Icons.camera_alt, size: 20),
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8.0,
                    right: MediaQuery.of(context).size.width / 2 - 70,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          height: 120,
                          width: 120,
                          child: Center(
                            child: SizedBox(
                              child: user['profile_photo_path'] == null
                                  ? CircleAvatar(
                                      backgroundImage: AssetImage(
                                        "images/cm${random.nextInt(10)}.jpeg",
                                      ),
                                      radius: 50,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        user['profile_photo_path'],
                                      ),
                                      radius: 50,
                                    ),
                              width: 115,
                              height: 115,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 20.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 16,
                            width: 16,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      user['online_status']?['status'] == true
                                          ? Colors.greenAccent
                                          : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                height: 14,
                                width: 14,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.0,
                          right: 8.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                height: 28,
                                width: 28,
                                child: const Center(
                                  child: Icon(Icons.camera_alt, size: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${user['full_name']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 3),
              const Divider(
                color: Colors.grey,
              ),
              Text(
                "${user['info']?['story'] ?? ''}",
                style: const TextStyle(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextButton(
                    child: const Icon(
                      Icons.message,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      print('123');
                      Get.to(
                        () => const Profile(
                          key: Key('edb1d5bf-472e-3944-bd29-c2a139848662'),
                          id: 'edb1d5bf-472e-3944-bd29-c2a139848662',
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    child: const Icon(
                      Icons.add,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Get.replace(
                        () => Profile(
                          id: '65c60f3e-9228-313c-bdd2-ec249c023113',
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${user['info']?['likes'] ?? 0}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Get.to(
                        () => Profile(
                          id: '74df8e70-c94d-3d30-8719-0445372817e7',
                        ),
                      );
                    },
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
            color: Colors.grey,
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

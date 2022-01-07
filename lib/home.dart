import 'package:flutter/material.dart';
import 'package:snest/screens/chat.dart';
import 'package:snest/screens/dashboard.dart';
import 'package:snest/screens/notification.dart';
import 'package:snest/screens/setting.dart';
import 'package:snest/store/auth.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final AuthController authController = Get.put(AuthController());
  int currentTab = 0;
  final List<Widget> screens = [
    const Dashboard(),
    const Chat(),
    const NotificationScreen(),
    const Setting(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentSreen = const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentSreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authController.increate();
        },
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentTab = 0;
                      currentSreen = const Dashboard();
                    });
                  },
                  shape: currentTab == 0
                      ? const Border(
                          top: BorderSide(width: 3, color: Colors.blue))
                      : null,
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: currentTab == 0 ? Colors.blue : Colors.grey,
                      ),
                      Text(
                        'Trang chủ',
                        style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                            fontSize: 10),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      currentTab = 1;
                      currentSreen = const Chat();
                    });
                  },
                  shape: currentTab == 1
                      ? const Border(
                          top: BorderSide(width: 3, color: Colors.blue))
                      : null,
                  minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message,
                        color: currentTab == 1 ? Colors.blue : Colors.grey,
                      ),
                      Text(
                        'Tin nhắn',
                        style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                            fontSize: 10),
                      )
                    ],
                  ),
                ),
              ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentTab = 2;
                        currentSreen = const NotificationScreen();
                      });
                    },
                    shape: currentTab == 2
                        ? const Border(
                            top: BorderSide(width: 3, color: Colors.blue))
                        : null,
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Thông báo',
                          style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey,
                              fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentTab = 3;
                        currentSreen = const Setting();
                      });
                    },
                    shape: currentTab == 3
                        ? const Border(
                            top: BorderSide(width: 3, color: Colors.blue))
                        : null,
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Cài đặt',
                          style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey,
                              fontSize: 10),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snest/store/auth.dart';
import 'package:get/get.dart';
import 'package:snest/util/data.dart';
import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snest/components/post_item.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthController authController = Get.find();
  String input = '';
  Timer? _debouncer;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int itemCount = 5;

  void _onRefresh() async {
    setState(() {
      itemCount = 0;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      itemCount = 5;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      itemCount += 5;
    });
    _refreshController.loadComplete();
  }

  _onInputChange(String value) {
    if (_debouncer?.isActive ?? false) _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        input = value;
      });
    });
  }

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
            onPressed: () {
              _showFullModal(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropMaterialHeader(),
          controller: _refreshController,
          footer: CustomFooter(
            builder: _buildCustomFooter,
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: itemCount,
            itemBuilder: _buildPostItem,
          )),
    );
  }

  Widget _buildPostItem(BuildContext context, int index) {
    final int len = posts.length;
    final int i = index % len;
    Map post = posts[i];
    return PostItem(
      img: post['img'],
      name: post['name'],
      dp: post['dp'],
      time: post['time'],
    );
  }

  Widget _buildCustomFooter(BuildContext context, LoadStatus? mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = const Text("Kéo xuống để tải thêm");
    } else if (mode == LoadStatus.loading) {
      body = const CupertinoActivityIndicator();
    } else if (mode == LoadStatus.failed) {
      body = const Text("Tải thất bại! Click để thử lại");
    } else if (mode == LoadStatus.canLoading) {
      body = const Text("Thả lên để tải thêm");
    } else {
      body = const Text("Đã tải hết dữ liệu");
    }
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  }

  _showBottomModal(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            height: 800,
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0, // has the effect of softening the shadow
                    spreadRadius: 0.0, // has the effect of extending the shadow
                  )
                ],
              ),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10),
                        child: const Text(
                          "Bottom Modal",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5, right: 5),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff999999),
                              ),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xfff8f8f8),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.justify,
                          text: const TextSpan(
                              text:
                                  "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black,
                                  wordSpacing: 1)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _showFullModal(context) {
    showGeneralDialog(
      context: context,
      barrierDismissible:
          false, // should dialog be dismissed when tapped outside
      barrierLabel: "Modal", // label for barrier
      transitionDuration: const Duration(
          milliseconds:
              200), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                ),
                onPressed: () {
                  _debouncer?.cancel();
                  Navigator.pop(context);
                }),
            elevation: 0.0,
            title: TextFormField(
                decoration: const InputDecoration.collapsed(
                  hintText: 'Tìm kiếm',
                ),
                autofocus: true,
                initialValue: input,
                onChanged: _onInputChange),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
          // backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tìm kiếm gần đây',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextButton(
                      child: Text(
                        'Xem tất cả',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: _itemBuilder,
                        separatorBuilder: (_, __) {
                          return const SizedBox(
                            height: 2,
                          );
                        },
                        itemCount: 20),
                  ),
                  const Text('Thử tìm'),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: _itemBuilder,
                        separatorBuilder: (_, __) {
                          return const SizedBox(
                            height: 2,
                          );
                        },
                        itemCount: 20),
                  )
                ],
              ))
            ],
          ),
        );
      },
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final itemLength = friends.length;
    final int itemIndex = index % itemLength;
    final Map friend = friends[itemIndex];
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(friend['dp']),
        radius: 18,
      ),
      title: Text(friend['name']),
      dense: true,
      trailing: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {},
      ),
    );
  }
}

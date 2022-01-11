import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snest/store/auth.dart';
import 'package:get/get.dart';
import 'package:snest/util/data.dart';
import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snest/components/post_item.dart';
import 'package:snest/util/http.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthController authController = Get.find();
  String input = '';
  Timer? _debouncer;
  List posts = [];
  int itemCount = 0;
  bool isOver = false;
  int indexSelected = -1;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<bool> _fetchPost({bool? isRefresh = true}) async {
    if (isRefresh != true && isOver) return false;
    try {
      int offset = 0;
      const int limit = 5;
      if (isRefresh != true) {
        offset = itemCount;
      } else {
        setState(() {
          isOver = false;
          itemCount = 0;
          posts = [];
        });
      }
      var query = {
        'offset': '$offset',
        'limit': '$limit',
      };
      List res = await HttpService.get('/v1/user/post', query);
      print(res.length < limit);
      setState(() {
        if (res.length < limit) {
          isOver = true;
        }
        if (isRefresh != true) {
          posts.addAll(res);
          itemCount += res.length;
        } else {
          posts = res;
          itemCount = res.length;
        }
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void _onRefresh() async {
    await _fetchPost(isRefresh: true);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    final success = await _fetchPost(isRefresh: false);
    if (success) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
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
  void initState() {
    _fetchPost(isRefresh: true);
    super.initState();
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
            itemCount: itemCount,
            itemBuilder: _buildPostItem,
          )),
    );
  }

  Future<void> _handleLike(int postId, String? likeStatus) async {
    try {
      await HttpService.post(
        '/v1/user/post/$postId/handle_like',
        {'status': likeStatus ?? '0'},
      );
    } catch (err) {
      print(err);
    }
  }

  Widget _buildPostItem(BuildContext context, int index) {
    final post = posts[index];
    final List<String> images = (post['images'] as List)
        .map((image) => image['path'] as String)
        .toList();
    return PostItem(
      name: post['user_name'],
      avatar: post['user_profile_photo_path'],
      time: post['created_at'],
      content: post['content'],
      images: images,
      id: post['id'],
      privacy: post['privacy'],
      pid: post['uid'],
      onLike: _handleLike,
      likeStatus: post['like_status'] != null
          ? '${post['like_status']['status']}'
          : null,
      onOptions: () {
        _showBottomModal(context);
        setState(
          () {
            indexSelected = index;
          },
        );
      },
      onShare: () {
        _showBottomShareModal(context);
        setState(
          () {
            indexSelected = index;
          },
        );
      },
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
          height: 300,
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
                _buildOptionItem(
                  icon: const Icon(Icons.bookmark_add),
                  title: 'Lưu liên kết',
                  description: 'Thêm vào danh sách liên kết của bạn',
                ),
                const Divider(),
                _buildOptionItem(
                  icon: const Icon(Icons.bookmark_add),
                  title: 'Lưu liên kết',
                  description: 'Thêm vào danh sách liên kết của bạn',
                ),
                const Divider(),
                _buildOptionItem(
                  icon: const Icon(Icons.bookmark_add),
                  title: 'Lưu liên kết',
                  description: 'Thêm vào danh sách liên kết của bạn',
                ),
                const Divider(),
                _buildOptionItem(
                  icon: const Icon(Icons.bookmark_add),
                  title: 'Lưu liên kết',
                  description: 'Thêm vào danh sách liên kết của bạn',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showBottomShareModal(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Container(
          height: 300,
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
                _buildOptionItem(
                  icon: const Icon(Icons.bookmark_add),
                  title: 'Lưu liên kết',
                  description: 'Thêm vào danh sách liên kết của bạn',
                ),
                const Divider(),
                _buildOptionItem(
                  icon: const Icon(Icons.bookmark_add),
                  title: 'Lưu liên kết',
                  description: 'Thêm vào danh sách liên kết của bạn',
                ),
                const Divider(),
                _buildOptionItem(
                  icon: const Icon(Icons.bookmark_add),
                  title: 'Lưu liên kết',
                  description: 'Thêm vào danh sách liên kết của bạn',
                ),
                const Divider(),
                _buildOptionItem(
                  icon: const Icon(Icons.bookmark_add),
                  title: 'Lưu liên kết',
                  description: 'Thêm vào danh sách liên kết của bạn',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionItem({
    required Icon icon,
    required String title,
    required String description,
  }) {
    return InkWell(
      onTap: () {
        print('123');
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
        child: Row(
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(description, style: const TextStyle(fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
                      itemCount: 20,
                    ),
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
                      itemCount: 20,
                    ),
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

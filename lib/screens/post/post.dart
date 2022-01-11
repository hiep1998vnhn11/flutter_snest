import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snest/components/reaction/data/example_data.dart' as example;
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:snest/store/auth.dart';
import 'package:snest/util/http.dart';
import 'package:snest/store/post.dart';
import 'package:snest/util/format/date.dart';
import 'package:snest/components/reaction/reaction_builder.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    Key? key,
    required this.id,
    this.content = '',
    this.avatar,
    this.name,
    this.privacy = 1,
    required this.pid,
  }) : super(key: key);

  final int id;
  final String? content;
  final String? avatar;
  final String? name;
  final int privacy;
  final String pid;
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<String> images = [];
  List<dynamic> comments = [];
  int commentCount = 0;
  String content = '';
  String commentContent = '';
  String? likeStatus;
  int totalLike = 0;
  int totalShare = 0;
  int totalComment = 0;
  List likeGroup = [];
  String createdAt = '';
  PostController postController = Get.find();
  AuthController authController = Get.find();
  TextEditingController commentController = TextEditingController();

  Future<void> _fetchPost() async {
    try {
      final String url = '/v1/user/post/${widget.pid}';
      final Map<String, dynamic> res = await HttpService.get(url);
      final List<String> imgs = (res['images'] as List)
          .map((image) => image['path'] as String)
          .toList();
      setState(() {
        images = imgs;
        content = res['content'] as String;
        likeStatus = res['like_status'] != null
            ? '${res['like_status']['status']}'
            : null;
        likeGroup = res['like_group'] ?? [];
        totalLike = res['liked_count'] ?? 0;
        totalShare = res['shared_count'] ?? 0;
        totalComment = res['comments_count'] ?? 0;
        createdAt = FormatDate.formatTimeAgo(res['created_at'] as String);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _fetchComments() async {
    try {
      final String url = '/v1/user/post/${widget.pid}/comment';
      final List<dynamic> res = await HttpService.get(
          url, {'offset': '$commentCount', 'limit': '10'});
      setState(() {
        comments.addAll(res);
        commentCount += res.length;
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _onComment() async {
    if (commentContent.isEmpty) return;
    final randomId = Random().nextInt(100000000);
    final String content = commentContent;
    try {
      final comment = {
        'content': commentContent,
        'id': randomId,
        'liked_count': 0,
        'user': {
          'full_name': authController.user.value['full_name'],
          'profile_photo_path': authController.user.value['profile_photo_path'],
          'url': authController.user.value['url'],
        }
      };
      commentController.clear();
      setState(() {
        comments.insert(0, comment);
        commentCount += 1;
        commentContent = '';
      });
      final String url = '/v1/user/post/${widget.pid}/comment';
      final Map<String, dynamic> res = await HttpService.post(url, {
        'content': content,
      });
      final int index =
          comments.indexWhere((comment) => comment['id'] == randomId);
      if (index != -1) {
        setState(() {
          comments[index]['created_at'] = res['created_at'];
          comments[index]['id'] = res['id'];
        });
      }
    } catch (e) {
      _toastError('Có lỗi xảy ra, xin hãy thử lại sau!');
      final int index =
          comments.indexWhere((comment) => comment['id'] == randomId);
      if (index != -1) {
        setState(() {
          comments.removeAt(index);
          commentCount -= 1;
        });
      }
      print(e);
    }
  }

  void _toastError(String value) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void initState() {
    _fetchPost();
    _fetchComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ListTile(
          leading: widget.avatar != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.avatar!,
                  ),
                )
              : const CircleAvatar(
                  backgroundImage: AssetImage('images/avatar.png'),
                ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          title: Text(
            widget.name ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                size: 20,
              ),
              onPressed: () {}),
          subtitle: Row(children: [
            Text(createdAt),
            const Text(' . '),
            ReactionBuilder.buildPrivacy(widget.privacy),
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFEEEEEEE),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              (commentContent == '' ? 110 : 160),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: commentController,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Hãy viết gì đó...',
                              ),
                              cursorColor: Colors.blue,
                              maxLines: 5,
                              minLines: 1,
                              onChanged: (String value) {
                                setState(() {
                                  commentContent = value;
                                });
                              },
                            ),
                          ),
                        ),
                        // IconButton(
                        //   padding: const EdgeInsets.all(0),
                        //   icon: const Icon(
                        //     Icons.emoji_emotions_outlined,
                        //   ),
                        //   onPressed: () {},
                        // ),
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.emoji_emotions_outlined,
                        //   ),
                        //   onPressed: () {},
                        // ),
                        IconButton(
                          icon: const Icon(
                            Icons.emoji_emotions_outlined,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                commentContent == ''
                    ? const SizedBox()
                    : IconButton(
                        icon: const Icon(Icons.send_outlined),
                        onPressed: _onComment,
                        color: Colors.blue,
                      )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.content ?? ''),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ReactionButtonToggle<String>(
                        onReactionChanged: (String? value, bool isChecked) {},
                        reactions: example.reactions,
                        initialReaction: example.defaultInitialReaction,
                        selectedReaction: example.reactions[
                            likeStatus == null || likeStatus == '0'
                                ? 0
                                : int.parse(likeStatus!) - 1],
                        isChecked: likeStatus != null && likeStatus != '0',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => {},
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Image.asset('images/icons/comment.png', height: 20),
                            const SizedBox(width: 5),
                            const Text('Bình luận'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            'Share image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Image.asset('images/icons/share.png', height: 20),
                            const SizedBox(width: 5),
                            const Text('chia sẻ'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Column(
              children: images.map((image) {
                return Column(
                  children: [
                    ClipRRect(
                      child: Image.network(
                        image,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .2,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: ReactionButtonToggle<String>(
                                onReactionChanged:
                                    (String? value, bool isChecked) {
                                  print(
                                      'Selected value: $value, isChecked: $isChecked');
                                },
                                reactions: example.reactions,
                                initialReaction: example.defaultInitialReaction,
                                selectedReaction: example.reactions[0],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.message,
                                  size: 20,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'Bình luận',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ReactionBuilder.buildLikeGroup(likeGroup, totalLike),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  totalComment == 0
                      ? const Text('Bài viết chưa có bình luận!')
                      : Text(
                          '$totalComment bình luận',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: const [
                  Text('Bài viết chưa có lượt chia sẻ nào!'),
                ],
              ),
            ),
            const Divider(),
            ..._buildListComment(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListComment() {
    return comments.map((comment) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
              comment['user']['profile_photo_path'],
            ),
            radius: 18,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment['user']['full_name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          comment['content'],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    )),
              ),
              comment['created_at'] == null
                  ? const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Đang viết ...'),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width - 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                FormatDate.formatTimeAgo(comment['created_at']),
                                style: const TextStyle(fontSize: 14),
                              ),
                              TextButton(
                                child: Text(
                                  'Thích',
                                  style: TextStyle(
                                    color: comment['like_status'] == 0 ||
                                            comment['like_status'] == null
                                        ? Colors.black
                                        : Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () {
                                  _onCommentLike(comment['id']);
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Phản hổi',
                                  style: TextStyle(
                                    color: comment['like_status'] == true
                                        ? Colors.blue
                                        : Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          comment['liked_count'] > 0
                              ? Row(
                                  children: [
                                    Text('${comment['liked_count']}'),
                                    const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'images/reactions/like.png'),
                                      radius: 8,
                                    ),
                                  ],
                                )
                              : Row(),
                        ],
                      ),
                    ),
            ],
          ),
        ],
      );
    }).toList();
  }

  Future<void> _onCommentLike(int id) async {
    try {
      int index = comments.indexWhere((comment) => comment['id'] == id);
      if (index == -1) return;
      final int status = comments[index]['like_status'] == null ||
              comments[index]['like_status'] == 0
          ? 1
          : 0;
      setState(() {
        comments[index]['liked_count'] = status == 1
            ? comments[index]['liked_count'] + 1
            : comments[index]['liked_count'] - 1;
        comments[index]['like_status'] = status;
      });
      final String url = '/v1/user/post/comment/$id/like';
      await HttpService.post(url, {'status': '$status'});
    } catch (e) {
      print(e);
    }
  }

  border() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Color(0xffB3ABAB),
        width: 1.0,
      ),
    );
  }
}

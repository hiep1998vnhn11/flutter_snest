import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snest/components/reaction/data/example_data.dart' as Example;
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:snest/util/http.dart';
import 'package:snest/components/bottom_input.dart';

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
  List<Map<String, int>> likeGroup = [];

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
        likeGroup = res['likeGroup'] ?? [];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _fetchComments() async {
    try {
      final String url = '/v1/user/post/${widget.pid}/get_comment';
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
            const Text('2 giờ trước'),
            const Text(' . '),
            _buildPrivacy(widget.privacy),
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
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Hãy viết gì đó...',
                              ),
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
                        onPressed: () {},
                        color: Colors.blue,
                      )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.content ?? ''),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ReactionButtonToggle<String>(
                        onReactionChanged: (String? value, bool isChecked) {},
                        reactions: Example.reactions,
                        initialReaction: Example.defaultInitialReaction,
                        selectedReaction: Example.reactions[
                            likeStatus == null || likeStatus == '0'
                                ? 0
                                : int.parse(likeStatus!) - 1],
                        isChecked: likeStatus != null && likeStatus != '0',
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
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.share,
                          size: 20,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Chia sẻ',
                        ),
                      ],
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
                                reactions: Example.reactions,
                                initialReaction: Example.defaultInitialReaction,
                                selectedReaction: Example.reactions[0],
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text('Bài viết chưa có bình luận!'),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text('Bài viết chưa có lượt chia sẻ nào!'),
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
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            comment['user']['profile_photo_path'],
          ),
        ),
        title: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('2 giờ trước'),
                    TextButton(
                        child: Text(
                          'Thích',
                          style: TextStyle(
                            color: comment['like_status'] == true
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _onCommentLike(comment['id']);
                        }),
                    TextButton(child: const Text('Phản hồi'), onPressed: () {}),
                  ],
                ),
                comment['liked_count'] > 0
                    ? Row(
                        children: [
                          Text('${comment['liked_count']}'),
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('images/reactions/like.png'),
                            radius: 8,
                          ),
                        ],
                      )
                    : Row(),
              ],
            )
          ],
        ),
      );
    }).toList();
  }

  Widget _buildPrivacy(int privacy) {
    if (privacy == 1) {
      return const Icon(
        Icons.public,
        size: 16,
        color: Colors.grey,
      );
    } else if (privacy == 2) {
      return const Icon(
        Icons.supervised_user_circle,
        size: 15,
        color: Colors.grey,
      );
    } else if (privacy == 3) {
      return const Icon(
        Icons.lock_outline,
        size: 15,
        color: Colors.grey,
      );
    } else {
      return const Icon(
        Icons.public,
        size: 15,
        color: Colors.grey,
      );
    }
  }

  void _onCommentLike(int id) {
    int index = comments.indexWhere((comment) => comment['id'] == id);
    setState(() {
      comments[index]['liked_count'] = comments[index]['like_status'] == true
          ? comments[index]['liked_count'] - 1
          : comments[index]['liked_count'] + 1;
      comments[index]['like_status'] =
          comments[index]['like_status'] == true ? false : true;
    });
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

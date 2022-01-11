import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snest/components/reaction/data/example_data.dart' as Example;
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:snest/util/http.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({
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
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<String> images = [];
  String content = '';

  Future<void> _fetchPost() async {
    try {
      final String url = '/v1/user/post/${widget.pid}';
      final Map<String, dynamic> res = await HttpService.get(url);
      final List<String> imgs = (res['images'] as List)
          .map((image) => image['path'] as String)
          .toList();
      print(imgs);
      setState(() {
        images = imgs;
        content = res['content'] as String;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _fetchPost();
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
                        onReactionChanged: (String? value, bool isChecked) {
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
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
}

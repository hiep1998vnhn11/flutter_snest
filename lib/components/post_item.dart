import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snest/store/auth.dart';
import 'package:snest/screens/post/post.dart';
import 'package:snest/components/grid_image.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:snest/components/reaction/data/example_data.dart' as Example;
// import 'package:snest/screens/comment.dart';
import 'dart:convert';

class PostItem extends StatefulWidget {
  final String? avatar;
  final String name;
  final String time;
  final String? img;
  final String? content;
  final List<String> images;
  final int privacy;
  final int id;
  final String pid;
  final String? likeStatus;
  final Function(int, String?) onLike;
  final Function() onOptions;
  final Function() onShare;

  const PostItem({
    Key? key,
    this.avatar,
    required this.name,
    required this.time,
    this.img,
    this.content,
    this.images = const [],
    required this.id,
    required this.privacy,
    required this.pid,
    required this.onLike,
    this.likeStatus,
    required this.onOptions,
    required this.onShare,
  }) : super(key: key);
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: widget.avatar != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.avatar!,
                    ),
                  )
                : const CircleAvatar(
                    backgroundImage: AssetImage('images/avatar.png'),
                  ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            title: Text(
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                size: 20,
              ),
              onPressed: widget.onOptions,
            ),
            subtitle: Row(children: [
              const Text('2 giờ trước'),
              const Text(' . '),
              _buildPrivacy(),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text(widget.content ?? ''),
          ),
          GridImage(
            images: widget.images,
          ),
          Padding(
            child: Row(
              children: const [Text('123')],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ReactionButtonToggle<String>(
                      onReactionChanged: (String? value, bool isChecked) {
                        widget.onLike(widget.id, value);
                      },
                      reactions: Example.reactions,
                      initialReaction: Example.defaultInitialReaction,
                      selectedReaction: Example.reactions[
                          widget.likeStatus == null || widget.likeStatus == '0'
                              ? 0
                              : int.parse(widget.likeStatus!) - 1],
                      isChecked:
                          widget.likeStatus != null && widget.likeStatus != '0',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(
                    () => PostScreen(
                      id: widget.id,
                      privacy: widget.privacy,
                      avatar: widget.avatar,
                      name: widget.name,
                      content: widget.content,
                      pid: widget.pid,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
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
                ),
                InkWell(
                  onTap: widget.onShare,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
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
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildPrivacy() {
    if (widget.privacy == 1) {
      return const Icon(
        Icons.public,
        size: 16,
        color: Colors.grey,
      );
    } else if (widget.privacy == 2) {
      return const Icon(
        Icons.supervised_user_circle,
        size: 15,
        color: Colors.grey,
      );
    } else if (widget.privacy == 3) {
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

  void _showBottomSheetComments() {
    showBottomSheet(
      context: context,
      builder: (context) {
        return const Text('Comment');
        // return Comments([]);
      },
    );
  }

  Container _buildReactionsIcon(String path, Text text) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Image.asset(path, height: 20),
          const SizedBox(width: 5),
          text,
        ],
      ),
    );
  }
}

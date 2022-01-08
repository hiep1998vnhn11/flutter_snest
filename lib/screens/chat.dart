import 'package:flutter/material.dart';
import 'package:snest/util/data.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration.collapsed(
              hintText: 'Tìm kiếm', hintStyle: TextStyle(color: Colors.white)),
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.fullscreen),
            onPressed: () {
              _showFullModal(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showBottomModal(context);
            },
          ),
          IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                _showSimpleModalDialog(context);
              }),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: friends.length,
        itemBuilder: _itemBuilder,
        separatorBuilder: _separatorBuilder,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final Map friend = friends[index];
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(friend['dp']),
      ),
      title: Text(friend['name']),
      subtitle: Text(friend['status']),
      trailing: friend['isAccept']
          ? TextButton(
              onPressed: () {},
              child: const Text(
                'Huỷ kết bạn',
                style: TextStyle(color: Colors.grey),
              ))
          : TextButton(
              onPressed: () {},
              child: const Text(
                'Kết bạn',
                style: TextStyle(color: Colors.blue),
              )),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 0.5,
        width: MediaQuery.of(context).size.width / 1.3,
        child: const Divider(),
      ),
    );
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 350),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showBottomModal(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Container(
            // height: 800,
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
              500), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: const Text(
                "Modal",
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Overpass',
                    fontSize: 20),
              ),
              elevation: 0.0),
          backgroundColor: Colors.white.withOpacity(0.90),
          body: Container(
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
          ),
        );
      },
    );
  }
}

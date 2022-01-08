import 'package:flutter/material.dart';
import 'package:snest/util/data.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NotificationScreen'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: _itemBuilder,
            separatorBuilder: _separatorBuilder,
            itemCount: notifications.length));
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

  Widget _itemBuilder(BuildContext context, int index) {
    Map notification = notifications[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(notification['dp']),
          radius: 25,
        ),
        contentPadding: const EdgeInsets.all(0),
        title: Text(notification['notif']),
        trailing: Text(
          notification['time'],
          style: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 11),
        ),
        onTap: () {},
      ),
    );
  }
}

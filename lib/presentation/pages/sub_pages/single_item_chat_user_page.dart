import 'package:flutter/material.dart';

class SingleItemChatUserPage extends StatelessWidget {
  final String? time;
  final String? recentSendMessage;
  final String? name;

  const SingleItemChatUserPage(
      {Key? key, this.time, this.recentSendMessage, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Image.asset("assets/profile_default.png"),
        ),
        title: Text("$name"),
        subtitle: Text("$recentSendMessage"),
        trailing: Text("$time"),
      ),
    );
  }
}

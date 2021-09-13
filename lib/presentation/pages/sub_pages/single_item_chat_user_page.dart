import 'package:flutter/material.dart';

class SingleItemChatUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Image.asset("assets/profile_default.png"),
        ),
        title: Text("User"),
        subtitle: Text("This is a message"),
        trailing: Text("12:20"),
      ),
    );
  }
}

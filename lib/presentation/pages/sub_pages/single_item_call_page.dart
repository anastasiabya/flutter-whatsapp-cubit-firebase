import 'package:flutter/material.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

class SingleItemCallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Image.asset("assets/profile_default.png"),
        ),
        title: Text("User Name"),
        subtitle: Row(
          children: <Widget>[
            Icon(Icons.call_received, color: primaryColor,),
            Text("Yesterday"),
          ],
        ),
        trailing: Icon(Icons.call, color: primaryColor,),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:whatsapp/presentation/pages/sub_pages/single_item_chat_user_page.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _emptyListDisplayMessageWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightPrimaryColor,
        onPressed: () {},
        child: Icon(Icons.chat),
      ),
    );
  }

  Widget _emptyListDisplayMessageWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: lightPrimaryColor.withOpacity(.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: Icon(
            Icons.message,
            color: Colors.white.withOpacity(.6),
            size: 40,
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Start chat with your friends and family,\n on WhatsApp Clone",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(.4)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _myChatList() {
    return Expanded(
        child: ListView.separated(
      itemCount: 10,
      itemBuilder: (_, index) {
        return SingleItemChatUserPage();
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 80, right: 10),
          child: Divider(
            height: 1,
          ),
        );
      },
    ));
  }
}

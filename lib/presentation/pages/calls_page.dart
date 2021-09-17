import 'package:flutter/material.dart';
import 'package:whatsapp/presentation/pages/sub_pages/single_item_call_page.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: ListView.separated(itemCount: 10,
            itemBuilder: (_, index) {
              return SingleItemCallPage();
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 80, right: 10),
                child: Divider(height: 1,),
              );
            },))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {},
        child: Icon(Icons.add_call),
      ),
    );
  }
}
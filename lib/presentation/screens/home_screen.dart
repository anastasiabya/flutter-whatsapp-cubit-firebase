import 'package:flutter/material.dart';
import 'package:whatsapp/domain/entities/user_entity.dart';
import 'package:whatsapp/presentation/pages/calls_page.dart';
import 'package:whatsapp/presentation/pages/camera_page.dart';
import 'package:whatsapp/presentation/pages/chat_page.dart';
import 'package:whatsapp/presentation/pages/status_page.dart';
import 'package:whatsapp/presentation/widgets/custom_tab_bar.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity? userInfo;

  const HomeScreen({Key? key, this.userInfo}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearch = false;
  int _currentPageIndex = 1;
  PageController _pageViewController = PageController(initialPage: 1);

  List<Widget> get _pages => [
        CameraPage(),
        ChatPage(userInfo: widget.userInfo,),
        StatusPage(),
        CallsPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _currentPageIndex != 0 ? AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor:
              _isSearch == false ? primaryColor : Colors.transparent,
          title: _isSearch == false
              ? Text(
                  "WhatsApp",
                  style: TextStyle(color: Colors.white),
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          flexibleSpace: _isSearch == false
              ? Container(
                  height: 0.0,
                  width: 0.0,
                )
              : _buildSearch(),
          actions: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  _isSearch = true;
                });
              },
              child: _isSearch == false
                  ? Icon(Icons.search, color: Colors.white)
                  : SizedBox.shrink(),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ],
        ) : null,
        body: Column(children: <Widget>[
          _isSearch == false
              ? _currentPageIndex != 0
                  ? CustomTabBar(index: _currentPageIndex)
                  : Container(
                      height: 0.0,
                      width: 0.0,
                    )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          Expanded(
            child: PageView.builder(
              itemCount: _pages.length,
              controller: _pageViewController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return _pages[index];
              },
            ),
          ),
        ]));
  }

  _buildSearch() {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            spreadRadius: 1,
            offset: Offset(0.0, 0.50),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          prefixIcon: InkWell(
            onTap: () {
              setState(() {
                _isSearch = false;
              });
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

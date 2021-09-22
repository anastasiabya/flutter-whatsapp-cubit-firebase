import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/presentation/bloc/communication/communication_cubit.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

class SingleCommunicationPage extends StatefulWidget {
  final String? senderUID;
  final String? recipientUID;
  final String? senderName;
  final String? recipientName;
  final String? senderPhoneNumber;
  final String? recipientPhoneNumber;

  const SingleCommunicationPage(
      {Key? key,
      this.senderUID,
      this.recipientUID,
      this.senderName,
      this.recipientName,
      this.senderPhoneNumber,
      this.recipientPhoneNumber})
      : super(key: key);

  @override
  _SingleCommunicationPageState createState() =>
      _SingleCommunicationPageState();
}

class _SingleCommunicationPageState extends State<SingleCommunicationPage> {
  TextEditingController _textMessageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  static const _limitIncrement = 10;
  int _limit = 10;
  double _lastScrollMessage = 0;

  @override
  void initState() {
    BlocProvider.of<CommunicationCubit>(context).getMessages(
        senderId: widget.senderUID,
        recipientId: widget.recipientUID,
        limit: _limit);
    _textMessageController.addListener(() {
      setState(() {});
    });
    _scrollController.addListener(() {
      if (_lastScrollMessage < _scrollController.position.maxScrollExtent) {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          BlocProvider.of<CommunicationCubit>(context).getMessages(
              senderId: widget.senderUID,
              recipientId: widget.recipientUID,
              limit: _limit + _limitIncrement);
          _lastScrollMessage = _scrollController.position.maxScrollExtent;
          _limit += _limitIncrement;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _textMessageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: 30, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  child: Image.asset(
                    "assets/profile_default.png",
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "${widget.recipientName}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            Icon(Icons.videocam, color: Colors.white),
            SizedBox(
              width: 8,
            ),
            Icon(Icons.call, color: Colors.white),
            SizedBox(
              width: 8,
            ),
            Icon(Icons.more_vert, color: Colors.white),
          ],
        ),
        body: BlocBuilder<CommunicationCubit, CommunicationState>(
          builder: (_, communicationState) {
            if (communicationState is CommunicationLoaded) {
              return _bodyWidget(communicationState);
            }
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          },
        ));
  }

  Widget _bodyWidget(CommunicationLoaded communicationState) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Image.asset(
            "assets/background_wallpaper.png",
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: <Widget>[
            _messagesListWidget(communicationState),
            _sendMessageTextField(),
          ],
        ),
      ],
    );
  }

  _messagesListWidget(CommunicationLoaded messages) {
    Timer(Duration(milliseconds: 1), () {
      _scrollController.animateTo(_lastScrollMessage,
          duration: Duration(milliseconds: 1), curve: Curves.easeInQuad);
    });
    return Expanded(
      child: ListView.builder(
        reverse: true,
        controller: _scrollController,
        itemCount: messages.messages!.length,
        itemBuilder: (_, index) {
          final message = messages.messages![index];
          if (message.sederUID == widget.senderUID) {
            return _messageLayout(
              color: greenMessage,
              time: DateFormat('hh:mm a').format(message.time!.toDate()),
              align: TextAlign.left,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.end,
              nip: BubbleNip.rightTop,
              text: message.message,
            );
          } else {
            return _messageLayout(
              color: whiteMessage,
              time: DateFormat('hh:mm a').format(message.time!.toDate()),
              align: TextAlign.left,
              boxAlign: CrossAxisAlignment.start,
              crossAlign: CrossAxisAlignment.start,
              nip: BubbleNip.leftTop,
              text: message.message,
            );
          }
        },
      ),
    );
  }

  Widget _sendMessageTextField() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 4, right: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: Offset(0.0, 0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 60,
                      ),
                      child: Scrollbar(
                        child: TextField(
                          maxLines: null,
                          style: TextStyle(fontSize: 14),
                          controller: _textMessageController,
                          decoration: InputDecoration(
                              hintText: "Type a message",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.link),
                      SizedBox(
                        width: 10,
                      ),
                      _textMessageController.text.isEmpty
                          ? Icon(Icons.camera_alt)
                          : Text(""),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              if (_textMessageController.text.isNotEmpty) {
                _sendTextMessage();
              }
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: _textMessageController.text.isEmpty
                  ? Icon(Icons.mic, color: Colors.white)
                  : Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageLayout({
    text,
    time,
    color,
    align,
    boxAlign,
    nip,
    crossAlign,
  }) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(3),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    text,
                    textAlign: align,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(
                        fontSize: 12, color: Colors.black.withOpacity(.4)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _sendTextMessage() {
    if (_textMessageController.text.isNotEmpty) {
      BlocProvider.of<CommunicationCubit>(context).sendTextMessage(
        recipientId: widget.recipientUID,
        senderId: widget.senderUID,
        recipientPhoneNumber: widget.recipientPhoneNumber,
        senderPhoneNumber: widget.senderPhoneNumber,
        recipientName: widget.recipientName,
        senderName: widget.senderName,
        message: _textMessageController.text,
      );
      _textMessageController.clear();
    }
  }
}

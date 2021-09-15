import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/domain/entities/my_chat_entity.dart';

class MyChatModel extends MyChatEntity {
  MyChatModel({
    String? senderName,
    String? senderUID,
    String? recipientName,
    String? recipientUID,
    String? channelId,
    String? profileURL,
    String? recipientPhoneNumber,
    String? senderPhoneNumber,
    String? recentTextMessage,
    bool? isRead,
    bool? isArchived,
    Timestamp? time,
  }) : super(
          senderName: senderName,
          senderUID: senderUID,
          recipientName: recipientName,
          recipientUID: recipientUID,
          channelId: channelId,
          profileURL: profileURL,
          recipientPhoneNumber: recipientPhoneNumber,
          senderPhoneNumber: senderPhoneNumber,
          recentTextMessage: recentTextMessage,
          isRead: isRead,
          isArchived: isArchived,
          time: time,
        );

  factory MyChatModel.fromSnapShot(DocumentSnapshot snapshot) {
    return MyChatModel(
      senderName: snapshot['senderName'],
      senderUID: snapshot['senderUID'],
      senderPhoneNumber: snapshot['senderPhoneNumber'],
      recipientName: snapshot['recipientName'],
      recipientUID: snapshot['recipientUID'],
      recipientPhoneNumber: snapshot['recipientPhoneNumber'],
      channelId: snapshot['channelId'],
      time: snapshot['time'],
      isArchived: snapshot['isArchived'],
      isRead: snapshot['isRead'],
      recentTextMessage: snapshot['recentTextMessage'],
      profileURL: snapshot['profileURL'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "senderUID": senderUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "channelId": channelId,
      "profileURL": profileURL,
      "recipientPhoneNumber": recipientPhoneNumber,
      "senderPhoneNumber": senderPhoneNumber,
      "recentTextMessage": recentTextMessage,
      "isRead": isRead,
      "isArchived": isArchived,
      "time": time,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  TextMessageModel({
    String? senderName,
    String? sederUID,
    String? recipientName,
    String? recipientUID,
    String? messageType,
    String? message,
    String? messageId,
    Timestamp? time,
  }) : super(
          senderName: senderName,
          sederUID: sederUID,
          recipientName: recipientName,
          recipientUID: recipientUID,
          messsageType: messageType,
          message: message,
          messageId: messageId,
          time: time,
        );

  factory TextMessageModel.fromSnapShot(DocumentSnapshot snapshot) {
    return TextMessageModel(
      senderName: snapshot['senderName'],
      sederUID: snapshot['sederUID'],
      recipientName: snapshot['recipientName'],
      recipientUID: snapshot['recipientUID'],
      messageType: snapshot['messageType'],
      message: snapshot['message'],
      messageId: snapshot['messageId'],
      time: snapshot['time'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "sederUID": sederUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "messageType": messsageType,
      "message": message,
      "messageId": messageId,
      "time": time,
    };
  }
}

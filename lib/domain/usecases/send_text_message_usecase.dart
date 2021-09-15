import 'package:whatsapp/domain/entities/text_message_entity.dart';
import 'package:whatsapp/domain/repositories/firebase_repository.dart';

class SendTextMessageUseCase {
  final FirebaseRepository? repository;

  SendTextMessageUseCase({this.repository});

  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelId) async {
    return await repository!.sendTextMessage(textMessageEntity, channelId);
  }
}

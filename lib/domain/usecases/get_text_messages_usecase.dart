import 'package:whatsapp/domain/entities/text_message_entity.dart';
import 'package:whatsapp/domain/repositories/firebase_repository.dart';

class GetTextMessagesUseCase {
  final FirebaseRepository? repository;

  GetTextMessagesUseCase({this.repository});

  Stream<List<TextMessageEntity>> call(String channelId, int limit) {
    return repository!.getMessages(channelId, limit);
  }
}

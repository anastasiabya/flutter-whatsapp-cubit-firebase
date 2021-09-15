import 'package:whatsapp/domain/entities/my_chat_entity.dart';
import 'package:whatsapp/domain/repositories/firebase_repository.dart';

class AddToMyChatUseCase {
  final FirebaseRepository? repository;

  AddToMyChatUseCase({this.repository});

  Future<void> call(MyChatEntity myChatEntity) async {
    return await repository!.addToMyChat(myChatEntity);
  }
}

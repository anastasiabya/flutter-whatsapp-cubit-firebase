import 'package:whatsapp/domain/entities/user_entity.dart';
import 'package:whatsapp/domain/repositories/firebase_repository.dart';

class GetAllUserUseCase {
  final FirebaseRepository? repository;

  GetAllUserUseCase({this.repository});

  Stream<Set<UserEntity>> call() {
    return repository!.getAllUsers();
  }
}

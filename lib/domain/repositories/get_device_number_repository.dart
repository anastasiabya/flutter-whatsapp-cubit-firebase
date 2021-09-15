import 'package:whatsapp/domain/entities/contact_entity.dart';

abstract class GetDeviceNumberRepository {
  Future<List<ContactEntity>> getDeviceNumbers(context);
}

import 'package:whatsapp/domain/entities/contact_entity.dart';
import 'package:whatsapp/domain/repositories/get_device_number_repository.dart';

class GetDeviceNumberUseCase {
  final GetDeviceNumberRepository? deviceNumberRepository;

  GetDeviceNumberUseCase({this.deviceNumberRepository});

  Future<List<ContactEntity>> call(context) async {
    return deviceNumberRepository!.getDeviceNumbers(context);
  }
}

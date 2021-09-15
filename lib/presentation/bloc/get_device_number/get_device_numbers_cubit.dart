import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/domain/entities/contact_entity.dart';
import 'package:whatsapp/domain/usecases/get_device_numbers_usecase.dart';

part 'get_device_numbers_state.dart';

class GetDeviceNumbersCubit extends Cubit<GetDeviceNumbersState> {
  final GetDeviceNumberUseCase? getDeviceNumberUseCase;
  GetDeviceNumbersCubit({this.getDeviceNumberUseCase}) : super(GetDeviceNumbersInitial());

  Future<void> getDeviceNumbers(context)async{
    try{
      final contactNumbers=await getDeviceNumberUseCase!.call(context);
      emit(GetDeviceNumbersLoaded(contacts: contactNumbers));
    }catch(_){
      emit(GetDeviceNumbersFailure());
    }
  }
}
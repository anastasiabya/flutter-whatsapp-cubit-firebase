import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp/data/datasource/firebase_remote_datasource.dart';
import 'package:whatsapp/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:whatsapp/data/repositories/firebase_repository_impl.dart';
import 'package:whatsapp/domain/repositories/firebase_repository.dart';
import 'package:whatsapp/domain/usecases/get_create_current_user_usecase.dart';
import 'package:whatsapp/domain/usecases/get_current_uid_usecase.dart';
import 'package:whatsapp/domain/usecases/is_sign_in_usecase.dart';
import 'package:whatsapp/domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'package:whatsapp/domain/usecases/sign_out_usecase.dart';
import 'package:whatsapp/domain/usecases/verify_phone_number_usecase.dart';
import 'package:whatsapp/presentation/bloc/auth/auth_cubit.dart';
import 'package:whatsapp/presentation/bloc/phone_auth/phone_auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Futures bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));
  sl.registerFactory<PhoneAuthCubit>(() => PhoneAuthCubit(
      signInWithPhoneNumberUseCase: sl.call(),
      verifyPhoneNumberUseCase: sl.call(),
      getCreateCurrentUserUseCase: sl.call()));

  //useCase
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(
      () => SignInWithPhoneNumberUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
      () => VerifyPhoneNumberUseCase(repository: sl.call()));

  //repository

  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //remote data

  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), fireStore: sl.call()));

  //external

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}

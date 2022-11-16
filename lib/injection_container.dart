import 'package:clinic/features/auth/%20domain/repositories/Login_repositorie.dart';
import 'package:clinic/features/auth/%20domain/usecases/login_usecases.dart';
import 'package:clinic/features/auth/data/datasources/login_remote_date_source.dart';
import 'package:clinic/features/auth/data/repositories/login_repositories.dart';
import 'package:clinic/features/clinic/%20domain/repositories/ClinicRepositorie.dart';
import 'package:clinic/features/clinic/%20domain/usecases/add_clinic_today.dart';
import 'package:clinic/features/clinic/%20domain/usecases/get_all_clinic_today.dart';
import 'package:clinic/features/clinic/%20domain/usecases/update_clinic_data.dart';
import 'package:clinic/features/clinic/data/datasources/clinic_remote_data_source.dart';
import 'package:clinic/features/clinic/data/repositories/clinic_repositories.dart';
import 'package:clinic/features/sick/%20domain/repositories/Sick_repositorie.dart';
import 'package:clinic/features/sick/%20domain/usecases/add%20_sick.dart';
import 'package:clinic/features/sick/%20domain/usecases/get_all_sicks.dart';
import 'package:clinic/features/sick/%20domain/usecases/update_sick.dart';
import 'package:clinic/features/sick/data/datasources/sick_remote_data_source.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/visitor/%20domain/repositories/Visitor_repositorie.dart';
import 'package:clinic/features/visitor/%20domain/usecases/get_all_visitor_today.dart';
import 'package:clinic/features/visitor/%20domain/usecases/update_visitor_today.dart';
import 'package:clinic/features/visitor/data/datasources/visitor_remote_data_source.dart';
import 'package:clinic/features/visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import 'package:clinic/features/visitor/presentation/bloc/visitor/visitor_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/clinic/presentation/bloc/actions_clinic_bloc.dart';
import 'features/sick/data/repositories/sick_repositories.dart';
import 'features/visitor/ domain/usecases/add_visitor_today.dart';
import 'features/visitor/data/repositories/visitor_repositories.dart';

final sl = GetIt.instance;
Future<void> init() async{

  //Bloc

  sl.registerFactory(() => AddUpdateGetClinicBloc(getClinic: sl(),addClinic: sl(),
    updateClinic: sl(),));
  sl.registerFactory(() => AddUpdateGetSickBloc(getSick: sl(), addSick: sl(),
      updateSick: sl(), ));
  sl.registerFactory(() => VisitorBloc(getAllVisitors: sl()));
  sl.registerFactory(() => LoginBloc(loginMethod: sl()));
  sl.registerFactory(() => AddUpdateVisitorBloc(addVisitor: sl(),
      updateVisitor: sl()));

  //UseCase
  sl.registerLazySingleton(() => GetClinicData(sl()));
  sl.registerLazySingleton(() => GetAllVisitorToday(sl()));
  sl.registerLazySingleton(() => LoginUseCases(sl()));
  sl.registerLazySingleton(() => AddVisitorToday(sl()));
  sl.registerLazySingleton(() => UpdateVisitorToday(sl()));
  sl.registerLazySingleton(() => AddSick(sl()));
  sl.registerLazySingleton(() => UpdateSick(sl()));
  sl.registerLazySingleton(() => GetAllSick(sl()));
  sl.registerLazySingleton(() => AddClinicData(sl()));
  sl.registerLazySingleton(() => UpdateClinicData(sl()));


  //Repository
  sl.registerLazySingleton<ClinicRepository>(() => ClinicRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<VisitorRepository>(() => VisitorRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<SickRepository>(() => SickRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LoginRepositorie>(() => LoginRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<VisitorRemoteDataSource>(() =>
      VisitorRemoteDataSourceImpl(client:sl()));
  sl.registerLazySingleton<SickRemoteDataSource>(() =>
      SickRemoteDataSourceImple(client:sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(() =>
      LoginRemoteDataSourceImple(client:sl()));
  sl.registerLazySingleton<ClinicRemoteDataSource>(() =>
      ClinicRemoteDataSourceImple(client:sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  
}
part of 'injection_container.dart';

var sl = GetIt.instance;
Future<void> init() async{

  //Bloc

  sl.registerFactory(() => AddUpdateGetFeesBloc(getFeesOfDay: sl(),
      getFeesOfMonth: sl(), addFees: sl(), updateFeesData: sl(),
      deleteFeesData: sl()));
  sl.registerFactory(() => AddGetDoctorBloc(getDoctor: sl(),
      addDoctor: sl()));
  sl.registerFactory(() => EyesCubit());
  sl.registerFactory(() => CheckBoxCubit());
  sl.registerFactory(() => BottomCubit());
  sl.registerFactory(() => LocaleCubit(changeLanguageUseCase: sl(), cubitLanguage: 'en'));

  sl.registerFactory(() => AddUpdateUserBloc(addUser: sl(),
      updateUser: sl()));
  sl.registerFactory(() => AddGetNurseBloc( addNurse: sl(), getNurse: sl()));
  sl.registerFactory(() => AddUpdateGetClinicBloc(getClinic: sl(),addClinic: sl(),
    updateClinic: sl(),));
  sl.registerFactory(() => AddUpdateGetSickBloc(getSick: sl(), addSick: sl(),
    updateSick: sl(), getSickBasedOnUser: sl(), addSickReport: sl(), updateSickAsEntered: sl(), ));
  sl.registerFactory(() => VisitorBloc(getAllVisitors: sl()));
  sl.registerFactory(() => LoginBloc(loginMethod: sl()));
  sl.registerFactory(() => AddUpdateVisitorBloc(addVisitor: sl(),
      updateVisitor: sl()));

  //UseCase
  sl.registerLazySingleton(() => AddFees(sl()));
  sl.registerLazySingleton(() => AddDoctorData(sl()));
  sl.registerLazySingleton(() => AddSickReport(sl()));
  sl.registerLazySingleton(() => ChangeLanguageUseCase(sl()));
  sl.registerLazySingleton(() => AddNurseData(sl()));
  sl.registerLazySingleton(() => GetNurseData(sl()));
  sl.registerLazySingleton(() => GetSickBasedOnUser(sl()));
  sl.registerLazySingleton(() => GetDoctorData(sl()));
  sl.registerLazySingleton(() => DeleteFeesData(sl()));
  sl.registerLazySingleton(() => GetFeesOfDay(sl()));
  sl.registerLazySingleton(() => GetFeesOfMonth(sl()));
  sl.registerLazySingleton(() => UpdateFeesData(sl()));
  sl.registerLazySingleton(() => GetClinicData(sl()));
  sl.registerLazySingleton(() => GetAllVisitorToday(sl()));
  sl.registerLazySingleton(() => LoginUseCases(sl()));
  sl.registerLazySingleton(() => AddVisitorToday(sl()));
  sl.registerLazySingleton(() => UpdateVisitorToday(sl()));
  sl.registerLazySingleton(() => AddSick(sl()));
  sl.registerLazySingleton(() => UpdateSick(sl()));
  sl.registerLazySingleton(() => UpdateSickAsEntered(sl()));
  sl.registerLazySingleton(() => GetAllSick(sl()));
  sl.registerLazySingleton(() => AddClinicData(sl()));
  sl.registerLazySingleton(() => UpdateClinicData(sl()));
  sl.registerLazySingleton(() => AddUser(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));


  //Repository
  sl.registerLazySingleton<FeesRepository>(() => FeesRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<BaseLanguageRepository>(() => LanguageRepository(languageLocaleDataSource: sl()));
  sl.registerLazySingleton<DoctorRepository>(() => DoctorRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<NurseRepository>(() => NurseRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ClinicRepository>(() => ClinicRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<VisitorRepository>(() => VisitorRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<SickRepository>(() => SickRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LoginRepositorie>(() => LoginRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoriesImpl(
      remoteDataSource: sl(), networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<DoctorRemoteDataSource>(() =>
      DoctorRemoteDataSourceImple(client:sl()));
  sl.registerLazySingleton<BaseLanguageLocaleDataSource>(() =>
      LanguageLocaleDataSource(sharedPreferences: sl()));
  
  sl.registerLazySingleton<NurseRemoteDataSource>(() =>
      NurseRemoteDataSourceImple(client:sl()));
  sl.registerLazySingleton<FeesRemoteDataSource>(() =>
      FeesRemoteDataSourceImple(client:sl()));
  sl.registerLazySingleton<VisitorRemoteDataSource>(() =>
      VisitorRemoteDataSourceImpl(client:sl()));
  sl.registerLazySingleton<SickRemoteDataSource>(() =>
      SickRemoteDataSourceImple(client:sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(() =>
      LoginRemoteDataSourceImple(client:sl()));
  sl.registerLazySingleton<ClinicRemoteDataSource>(() =>
      ClinicRemoteDataSourceImple(client:sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(() =>
      UserRemoteDataSourceImple(client:sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}
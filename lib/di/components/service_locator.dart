import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/user_bloc/user_bloc.dart';
import 'package:real_estate/data/network/api/search_engine/search_api.dart';
import 'package:real_estate/data/network/api/users/user_api.dart';
import 'package:real_estate/data/network/dio_client.dart';
import 'package:real_estate/data/network/repository/search_repository.dart';
import 'package:real_estate/data/network/repository/user_repository.dart';
import 'package:real_estate/data/network/rest_client.dart';
import 'package:real_estate/data/sharedpref/shared_preference_helper.dart';
import 'package:real_estate/di/module/local_module.dart';
import 'package:real_estate/di/module/network_module.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  // getIt.registerFactory(() => ErrorStore());
  // getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(UserApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(SearchApi(getIt<DioClient>()));

  // data sources
  // getIt.registerSingleton(PostDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(UserRepository(
    getIt<UserApi>(),
    getIt<SharedPreferenceHelper>(),
    // getIt<PostDataSource>(),
  ));

  getIt.registerSingleton(SearchRepository(
    getIt<SearchApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  // stores:--------------------------------------------------------------------
  // getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  // getIt.registerSingleton(PostStore(getIt<Repository>()));
  // getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  // getIt.registerSingleton(UserStore(getIt<Repository>()));

  // blocs:---------------------------------------------------------------------
  getIt.registerSingleton(UserBloc(getIt<UserRepository>()));
  getIt.registerSingleton(SearchBloc(getIt<SearchRepository>()));
}

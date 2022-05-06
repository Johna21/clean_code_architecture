import 'package:clean_code_architecture/core/network/network_info.dart';
import 'package:clean_code_architecture/core/util/input_converter.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/repositories/number_trivia_repository_implementation.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async{
  //! Features-Number trivia
// bloc
  sl.registerFactory(() => NumberTriviaBloc(
    concrete: sl(), 
    random: sl(), 
    inputConverter: sl()
    ));
// usecase
  sl.registerLazySingleton(() => 
      GetConcereteNumberTrivia(sl()));

  sl.registerLazySingleton(() => 
      GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(() => 
        NumberTriviaRepositoryImp(
          remoteDataSource: sl(), 
          localDataSource: sl(), 
          networkInfo: sl())
        );

  // Datasource
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => 
      NumberTriviaRemoteDataSourceImpl(
        client: sl())
    );
    sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => 
      NumberTriviaLocalDataSourceImpl(
        sharedPreferences: sl())
    );

  //! core
  sl.registerLazySingleton(() => 
        InputConverter());
sl.registerLazySingleton<NetworkInfo>(() => 
        NetworkInfoImpl(
           connectionChecker: sl()
           ));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => InternetConnectionChecker());


}
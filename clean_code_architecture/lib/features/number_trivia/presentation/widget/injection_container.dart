import 'package:clean_code_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init(){
  //! Features-Number trivia
// bloc
  sl.registerFactory(() => NumberTriviaBloc(
    concrete: sl(), 
    random: sl(), 
    inputConverter: sl()
    ));

  //! core

  //! core
}
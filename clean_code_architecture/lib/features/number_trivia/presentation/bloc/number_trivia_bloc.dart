import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_code_architecture/core/util/input_converter.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcereteNumberTrivia getConcereteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
   final InputConverter inputConverter;

  NumberTriviaBloc(
    {
      required GetConcereteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required this.inputConverter,
    }
  ) :getConcereteNumberTrivia = concrete,
      getRandomNumberTrivia = random
   , super(Empty());
  //   {
  //   on<NumberTriviaEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }

  @override
  NumberTriviaState get initialState => Empty();

  @override 
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  )async*{
    
  }
 
}

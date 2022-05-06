import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_code_architecture/core/util/input_converter.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_random_number_trivia.dart';

import '../../../../core/errors/failure.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 
        'Invalid Input - The number must be positive integer or zero';


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
    // {
  //   on<NumberTriviaEvent>((event, emit) async*{
     
      
  //   if(event is GetTriviaForConcreteNumber){
  //     final inputEither =
  //     inputConverter.stringUnsignedInteger(event.numberString);
      
  //    emit* inputEither!.fold(
  //       (fail) async* {
  //         emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
  //       }, 
  //       (integer) => throw UnimplementedError());
  //   }
    
  
  //   });
  // }

  @override
  NumberTriviaState get initialState => Empty();

  @override 
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  )async*{
    if(event is GetTriviaForConcreteNumber){
      final inputEither =
          inputConverter.stringUnsignedInteger(event.numberString);

      yield* inputEither!.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await getConcereteNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
      
    }else if(event is GetTriviaForRandomNumber){
        
          yield Loading();
          final failureOrTrivia =
              await getRandomNumberTrivia(NoParams());
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        
      
    }

    
  }
  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure,NumberTrivia>? failureOrTrivia,
  ) async* {
    yield failureOrTrivia!.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServeFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

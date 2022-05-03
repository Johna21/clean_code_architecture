import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource{
  Future<NumberTriviaModel> getConcereteNumberTrivia( number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
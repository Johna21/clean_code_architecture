import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource{
  Future<NumberTriviaModel> getLasNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaCache);
}
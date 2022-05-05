
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure,NumberTrivia>>? getConcereteNumberTrivia(number);
  Future<Either<Failure,NumberTrivia>>? getRandomNumberTrivia();
}
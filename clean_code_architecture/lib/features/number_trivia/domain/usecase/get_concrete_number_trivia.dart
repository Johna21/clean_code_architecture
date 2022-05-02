
import 'package:clean_code_architecture/core/errors/failure.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

import '../repositories/number_trivia_repository.dart';

class GetConcereteNumberTrivia {
  final NumberTriviaRepository? repository;
  GetConcereteNumberTrivia(
    [ this.repository,]
  );

  Future<Either<Failure,NumberTrivia>?> call(
    int number
  ) async{
    return await repository!.getConcereteNumberTrivia(number);
  }

}

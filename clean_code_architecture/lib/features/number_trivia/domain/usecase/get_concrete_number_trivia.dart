
import 'package:clean_code_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_code_architecture/core/errors/failure.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';

import '../repositories/number_trivia_repository.dart';

class GetConcereteNumberTrivia implements UseCase<NumberTrivia,Params> {
  final NumberTriviaRepository repository;
  GetConcereteNumberTrivia(
    this.repository,
  );

  @override
  Future<Either<Failure,NumberTrivia>?> call(
   Params params
  ) async{
    return await repository.getConcereteNumberTrivia(params);
  }
  
}

class Params extends Equatable {
  final int number;
  Params({
    required this.number,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [number];

}

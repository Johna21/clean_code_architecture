
import 'package:clean_code_architecture/core/errors/failure.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type,Params>{
  Future<Either<Failure,Type>?> call(Params params);

}

abstract class UseCaseRandom<Type,NOParams>{
  Future<Either<Failure,Type>?> call(NoParams params);

}

 
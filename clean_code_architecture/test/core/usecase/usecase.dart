
import 'package:clean_code_architecture/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type,Params>{
  Future<Either<Failure,Type>> call(Params params);
}


import 'package:clean_code_architecture/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, int> stringUnsignedInteger(String str){
    try{
      final integer = int.parse(str);
      if(integer < 0) throw FormatException();
    return Right(integer);

    }on FormatException{
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  
}
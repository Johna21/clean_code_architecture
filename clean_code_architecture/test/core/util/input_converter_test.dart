import 'package:clean_code_architecture/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){
  late InputConverter inputConverter;

  setUp((){
    inputConverter = InputConverter();
  });

  group('String to UnsignedInt', 
  (){
    test('should return an integer when the string represents an unsigned integer',
     () async{
      //  arrange
      final str = '123';

      // act
      final result = inputConverter.stringUnsignedInteger(str);

      // assert
      expect(result, Right(int.parse(str)));
    }
    );

  test('shoud return failure when the string is a negative integer',
   () async {
    //  arrange
     final str = '-123';
    // act
    final result = inputConverter.stringUnsignedInteger(str);

    // assert

    expect(result, Left(InvalidInputFailure()));

  }
  );
  test('shoud return failure when the string is not an integer',
   () async {
    //  arrange
     final str = 'abc';
    // act
    final result = inputConverter.stringUnsignedInteger(str);

    // assert

    expect(result, Left(InvalidInputFailure()));

  }
  );

  });
}
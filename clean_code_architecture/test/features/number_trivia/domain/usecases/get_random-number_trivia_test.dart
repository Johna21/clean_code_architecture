
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock 
      implements NumberTriviaRepository{}

void main(){
  GetRandomNumberTrivia? usecase ;
  MockNumberTriviaRepository mockNumberTriviaRepository = MockNumberTriviaRepository();

  setUp((){

    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(
      mockNumberTriviaRepository);

  });

  final tNumbertrivia = NumberTrivia(text: "test", number: 1);
  test('should get trivia from the repository',
   () async {
    /*
    arrange
    */
     when(mockNumberTriviaRepository.getRandomNumberTrivia()).
     thenAnswer((_) async => Right(tNumbertrivia));

    // act
    if(usecase == null){
      final result = null;
    }
    final result = await usecase!(NoParams());

    // assert
    expect(result, Right(tNumbertrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);

  }
  );

}
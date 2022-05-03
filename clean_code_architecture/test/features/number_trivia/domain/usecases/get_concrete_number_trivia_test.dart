
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock 
      implements NumberTriviaRepository{}

void main(){
  late GetConcereteNumberTrivia usecase ;
   MockNumberTriviaRepository mockNumberTriviaRepository = MockNumberTriviaRepository();

  setUp((){

    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcereteNumberTrivia(
      mockNumberTriviaRepository);

  });

  final tNumber = 1;
  final tNumbertrivia = NumberTrivia(text: "test", number: 1);
  test('should get trivia from the number repository',
   () async {
    /*
    arrange
    */
     when(mockNumberTriviaRepository.getConcereteNumberTrivia(any)).
     thenAnswer((_) async => Right(tNumbertrivia));

    // act
    final result = await usecase(Params(number: tNumber));

    // assert
    expect(result, Right(tNumbertrivia));
    verify(mockNumberTriviaRepository.getConcereteNumberTrivia(Params(number: tNumber)));
    verifyNoMoreInteractions(mockNumberTriviaRepository);

  }
  );

}
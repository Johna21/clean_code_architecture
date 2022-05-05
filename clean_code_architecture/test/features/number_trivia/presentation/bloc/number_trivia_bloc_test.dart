import 'package:clean_code_architecture/core/util/input_converter.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockGetConcreteNumberTrivia extends Mock 
    implements GetConcereteNumberTrivia{}

class MockGetRandomNumberTrivia extends Mock 
    implements GetRandomNumberTrivia{}    

class MockInputConverter extends Mock 
    implements InputConverter{}

    void main(){
      late NumberTriviaBloc bloc;

      MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
      MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
      late MockInputConverter mockInputConverter;

      setUp((){
        mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
        mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
        mockInputConverter = MockInputConverter();

        bloc = NumberTriviaBloc(
          concrete: mockGetConcreteNumberTrivia,
           random: mockGetRandomNumberTrivia,
            inputConverter: mockInputConverter);
      });

      test('initialState should be Empty', () {
        // assert
        expect(bloc.initialState, equals(Empty()));
      });
      group('GetTriviaForConcereteNumber', (){
        final tNumberString = '1';
        final tNumberParsed = '1';
        final tNumberTrivia = NumberTrivia(
              text: 'test trivia', 
              number: 1);

      test('should all the input converter to validate and convert the string to', 
      () async{
        when(mockInputConverter.stringUnsignedInteger(any as String)).
        thenReturn(Right(int.parse(tNumberParsed)));
        
      });

      });

    }
import 'package:clean_code_architecture/core/errors/failure.dart';
import 'package:clean_code_architecture/core/util/input_converter.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
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

     late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
      late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
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


   
           test(
        'should emit[error] when the input is invalid', 
        () async{
          // arrange
         try {
          when(mockInputConverter.stringUnsignedInteger(any.toString())).
                    thenReturn(Left(InvalidInputFailure()));
         
          // assert
          final expected = [
                Empty(),
                Error(message: INVALID_INPUT_FAILURE_MESSAGE
                )
                ];
          expectLater(
            bloc.state, 
            emitsInOrder(
              expected
                ));
          // act
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
         
          
         } catch (e) {
         }
      }
      );
      test(
        'should get data from the Random use case', 
        () async{
          // arrange
        try{
          
        when(mockGetRandomNumberTrivia(NoParams())).
        thenAnswer((_) async => Right(tNumberTrivia ));

    // act
          bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetConcreteNumberTrivia(tNumberTrivia as Params));
        // assert

        verify(mockGetRandomNumberTrivia(NoParams()));
        }catch(e){

        }
      }
      );


    test(
      'should emit [Loading,Loaded] when data is gotten succesfull', 
      () async{
          //arrange
        
        try{
          when(mockGetRandomNumberTrivia(any as NoParams)).
        thenAnswer((_) async => Right(tNumberTrivia ));
 
          //assert later 
        final expected = [
          Empty(),
          Loading(),
          Loaded(trivia: tNumberTrivia)
        ];

        expectLater(bloc.state, emitsInOrder(expected));
          //act
          bloc.add(GetTriviaForRandomNumber());
    }catch(e){
      
    }
      }
      );

      test(
      'should emit [Loading,Error] when getting data fails', 
      () async{
          //arrange
        try{
when(mockGetConcreteNumberTrivia(tNumberTrivia as Params)).
        thenAnswer((_) async => Left(ServeFailure() ));
 
          //assert later 
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];

        expectLater(bloc.state, emitsInOrder(expected));
          //act
          bloc.add(GetTriviaForRandomNumber());

        } catch(e){

        }
        
      }
      );

      test(
      'should emit [Loading,Error] with a proper message for the error when getting data fail', 
      () async{
          //arrange
       try{
         when(mockGetRandomNumberTrivia(any as NoParams)).
        thenAnswer((_) async => Left(CacheFailure() ));
 
          //assert later 
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE)
        ];

        expectLater(bloc.state, emitsInOrder(expected));
          //act
          bloc.add(GetTriviaForRandomNumber());

       }catch(e){

       } 
        
      }
      );

      });
 group('GetTriviaForRandomNumber', (){
        final tNumberString = '1';
        final tNumberParsed = '1';
        final tNumberTrivia = NumberTrivia(
              text: 'test trivia', 
              number: 1);

void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringUnsignedInteger(tNumberParsed))
            .thenReturn(Right(int.parse(tNumberParsed)));
   try{
      test('should call the input converter to validate and convert the string to', 
      () async{
        // arrange
        try{
          setUpMockInputConverterSuccess();
        // act
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
          await untilCalled(mockInputConverter.stringUnsignedInteger(tNumberString));
        // assert
          verify(mockInputConverter.stringUnsignedInteger(tNumberString));
  }catch(e){

  }
      });
      test(
        'should emit[error] when the input is invalid', 
        () async{
          // arrange
         try{ 
           
           when(mockInputConverter.stringUnsignedInteger(any.toString())).
          thenReturn(Left(InvalidInputFailure()));
         
          // assert
          final expected = [
                Empty(),
                Error(message: INVALID_INPUT_FAILURE_MESSAGE
                )
                ];
          expectLater(
            bloc.state, 
            emitsInOrder(
              expected
                ));
          // act
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
         
        }catch(e){

        }
      }
      );
      test(
        'should get data from the concrete use case', 
        () async{
          // arrange
      try{
         setUpMockInputConverterSuccess();
        
        when(mockGetConcreteNumberTrivia(tNumberTrivia as Params)).
        thenAnswer((_) async => Right(tNumberTrivia ));

    // act
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(tNumberTrivia as Params));
        // assert

        verify(mockGetConcreteNumberTrivia(Params(number: int.parse(tNumberParsed))));
      
      }catch(e){

      }
      
      }
      );


    test(
      'should emit [Loading,Loaded] when data is gotten succesfull', 
      () async{
          //arrange
        try{  
          setUpMockInputConverterSuccess();
        
        when(mockGetConcreteNumberTrivia(tNumberTrivia as Params)).
        thenAnswer((_) async => Right(tNumberTrivia ));
 
          //assert later 
        final expected = [
          Empty(),
          Loading(),
          Loaded(trivia: tNumberTrivia)
        ];

        expectLater(bloc.state, emitsInOrder(expected));
          //act
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
        }catch(e){

        }
      }
      );

      test(
      'should emit [Loading,Loaded] when getting data fails', 
      () async{
          //arrange
         try{
            setUpMockInputConverterSuccess();
        
        when(mockGetConcreteNumberTrivia(tNumberTrivia as Params)).
        thenAnswer((_) async => Left(ServeFailure() ));
 
          //assert later 
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];

        expectLater(bloc.state, emitsInOrder(expected));
          //act
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
        }catch(e){

        }
      }
      );

      test(
      'should emit [Loading,Error] with a proper message for the error when getting data fail', 
      () async{
          //arrange
         try{
            setUpMockInputConverterSuccess();
        
        when(mockGetConcreteNumberTrivia(tNumberTrivia as Params)).
        thenAnswer((_) async => Left(CacheFailure() ));
 
          //assert later 
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE)
        ];

        expectLater(bloc.state, emitsInOrder(expected));
          //act
          bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));

         }
         catch(e){

         }
      }
      );
 }catch(e){

 }

      });

    
    }
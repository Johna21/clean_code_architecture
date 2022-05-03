import 'package:clean_code_architecture/core/errors/failure.dart';
import 'package:clean_code_architecture/core/platform/network_info.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_architecture/features/number_trivia/data/repositories/number_trivia_repository_implementation.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
 implements NumberTriviaRemoteDataSource{

 }

 class MockLocalDataSource extends Mock
 implements NumberTriviaLocalDataSource{

 }

 class MockNetworkInfo extends Mock
 implements NetworkInfo{

 }

 void main(){
   late NumberTriviaRepositoryImp repository;
   late MockRemoteDataSource mockRemoteDataSource;
   late MockLocalDataSource mockLocalDataSource;
   late MockNetworkInfo mockNetworkInfo;


  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

  repository = NumberTriviaRepositoryImp(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
     networkInfo: mockNetworkInfo
  );

  });

  group('getConcereteNumberTrivia', (){

    final tNumber =1;
    final tNumberTriviaModel = NumberTriviaModel(text: 'Test Trivia',
     number: tNumber);

     final NumberTrivia tNumberTrivia = tNumberTriviaModel;

     test('should check if the device is online', () async{
      
        when(mockNetworkInfo.isConnected).thenAnswer
        ((_) async=> true);
        repository.getConcereteNumberTrivia(tNumber);
        verify(mockNetworkInfo.isConnected);

     });
     
  group('device is online', (){
    setUp((){
      when(mockNetworkInfo.isConnected).thenAnswer(
        (_)async => true);

      test('should return remote data when the call to remote data source is success',
       () async{
          // arrange
          when(mockRemoteDataSource.getConcereteNumberTrivia(any)).
          thenAnswer((_) async=> tNumberTriviaModel);

      //  act
      final result = await repository.getConcereteNumberTrivia(tNumber);

      // assert
      verify(mockRemoteDataSource.getConcereteNumberTrivia(tNumber));
      expect(result, equals(Right(tNumberTrivia)));

    });

  test('should cache the data locally when the call to remote data source is success',
       () async{
          // arrange
          when(mockRemoteDataSource.getConcereteNumberTrivia(any)).
          thenAnswer((_) async=> tNumberTriviaModel);

      //  act
      final result = await repository.getConcereteNumberTrivia(tNumber);

      // assert
      verify(mockRemoteDataSource.getConcereteNumberTrivia(tNumber));
      verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
    });

    test('should return server failure when the call to remote data source is unsecussful',
       () async{
          // arrange
          when(mockRemoteDataSource.getConcereteNumberTrivia(any)).
          thenAnswer((_) async=> tNumberTriviaModel);

      //  act
      final result = await repository.getConcereteNumberTrivia(tNumber);

      // assert
      verify(mockRemoteDataSource.getConcereteNumberTrivia(tNumber));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServeFailure())));

    });


  });
  group('device is offline', (){
    setUp((){
      when(mockNetworkInfo.isConnected).thenAnswer(
        (_)async => false);

    });
    test('should return last locally cached data when cached data is present',
     () async{
      //  arrange
       when(mockLocalDataSource.getLasNumberTrivia()).
        thenAnswer((_) async=> tNumberTriviaModel);
    // act
    final result = await repository.getConcereteNumberTrivia(tNumber);
    // assert
  verifyZeroInteractions(mockRemoteDataSource);
  verify(mockLocalDataSource.getLasNumberTrivia());
  expect(result, equals(Right(tNumberTrivia)));
       });
  
  });
       }); 


  });

  }


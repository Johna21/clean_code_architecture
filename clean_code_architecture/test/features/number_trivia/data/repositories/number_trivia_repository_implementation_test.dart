import 'package:clean_code_architecture/core/errors/exceptions.dart';
import 'package:clean_code_architecture/core/errors/failure.dart';
import 'package:clean_code_architecture/core/network/network_info.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_architecture/features/number_trivia/data/repositories/number_trivia_repository_implementation.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main(){
  late NumberTriviaRepositoryImp repository;
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImp(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo);

  });
  void runTestOnline(Function body){
    group('diviceis online',(){
      setUp((){
       try{ 
         when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    } catch(e){
      
    } 
    });

    body();
  });
  }
  void runTestOffline(Function body){
    group('diviceis offline',(){
      setUp((){
        try{
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        }catch(e){

        }
      });

    body();
  });}
  group('get concrete number trivia',(){
      final tNumber = 1;
      final tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: "test text");
      final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    runTestOnline(() async {


    
         try{
           test('should check if the device is online', (){     
      repository.getConcereteNumberTrivia(tNumber);
      verify(mockNetworkInfo.isConnected);
    });
    }catch(e){

    }
        
    test('should store the data locally when the call to remore data is successful',() async {
        try{
          when(mockRemoteDataSource.getConcereteNumberTrivia(any))
          .thenAnswer((_)async => tNumberTriviaModel);
         await repository.getConcereteNumberTrivia(tNumber);
         verify(mockRemoteDataSource.getConcereteNumberTrivia(tNumber));
         verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));         
     
        }catch(e){}
         });
      test('should return server failure when the call to remore data is unsuccessful',() async {
        when(mockRemoteDataSource.getConcereteNumberTrivia(any))
          .thenThrow(ServerException());
         final result = await repository.getConcereteNumberTrivia(tNumber);
         verify(mockRemoteDataSource.getConcereteNumberTrivia(tNumber));
         verifyZeroInteractions(mockLocalDataSource);
         expect(result, equals(Left(ServeFailure())));  
      });});
    runTestOffline((){
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_)async => false);
      });
      test('should return last locally cached data when the cache data is present',() async {
        when(mockLocalDataSource.getLasNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getConcereteNumberTrivia(tNumber);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLasNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
        });
        test('should return cache exception when the there is no cache data present',() async {
        when(mockLocalDataSource.getLasNumberTrivia()).thenThrow(CacheException());
        final result = await repository.getConcereteNumberTrivia(tNumber);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLasNumberTrivia());
        expect(result, equals(Left(CacheFailure())));

         
      });
    });
  });
  group('get random number trivia',(){
      final tNumberTriviaModel = NumberTriviaModel(number: 35, text: "test text");
      final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    runTestOnline(() async {

      test('should check if the device is online', (){     
      try{
        repository.getRandomNumberTrivia();
      verify(mockNetworkInfo.isConnected);
      }catch(e){

      }
    });
    test('should store the data locally when the call to remore data is successful',() async {
       try {
         when(mockRemoteDataSource.getRandomNumberTrivia())
          .thenAnswer((_)async => tNumberTriviaModel);
         await repository.getRandomNumberTrivia();
         verify(mockRemoteDataSource.getRandomNumberTrivia());
         verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));         
      }catch(e){

      }
      });
      test('should return server failure when the call to remore data is unsuccessful',() async {
        when(mockRemoteDataSource.getRandomNumberTrivia())
          .thenThrow(ServerException());
         final result = await repository.getRandomNumberTrivia();
         verify(mockRemoteDataSource.getRandomNumberTrivia());
         verifyZeroInteractions(mockLocalDataSource);
         expect(result, equals(Left(ServeFailure())));  
      });});
    runTestOffline((){
      test('should return last locally cached data when the cache data is present',() async {
        try{
          when(mockLocalDataSource.getLasNumberTrivia()).
          thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLasNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
        }catch(e){

        }
        });
        test('should return cache exception when the there is no cache data present',() async {
        try{
          when(mockLocalDataSource.getLasNumberTrivia()).
        thenThrow(CacheException());
        final result = await repository.getRandomNumberTrivia();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLasNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      }catch(e){

}
         
      });
    });
  });
}
import 'package:clean_code_architecture/core/platform/network_info.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_architecture/features/number_trivia/data/repositories/number_trivia_repository_implementation.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
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
   NumberTriviaRepositoryImp? repository;
   MockRemoteDataSource mockRemoteDataSource;
   MockLocalDataSource mockLocalDataSource;
   MockNetworkInfo? mockNetworkInfo;


  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

  repository = NumberTriviaRepositoryImp(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
     networkInfo: mockNetworkInfo!
  );

  });

  group('getConcereteNumberTrivia', (){

    final tNumber =1;
    final tNumberTriviaModel = NumberTriviaModel(text: 'Test Trivia',
     number: tNumber);

     final NumberTrivia tNumberTrivia = tNumberTriviaModel;

     test('should check if the device is online', () async{

        when(mockNetworkInfo!.isConnected).thenAnswer
        ((_) async=> true);
        repository!.getConcereteNumberTrivia(tNumber);
        verify(mockNetworkInfo!.isConnected);

     });
     
  });

 }


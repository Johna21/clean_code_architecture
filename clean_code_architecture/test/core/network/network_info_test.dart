import 'package:clean_code_architecture/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements InternetConnectionChecker{}
  
  void main(){
    late NetworkInfoImpl networkInfo;
    late MockDataConnectionChecker mockDataConnectionChecker;


    setUp((){
      mockDataConnectionChecker = MockDataConnectionChecker();
      networkInfo = NetworkInfoImpl(connectionChecker: mockDataConnectionChecker);
    });

    group('isConnecte', (){
      test('should forward the call to DataConnectioncheckr.hasconnection', 
      () async{
        // arrange
        final tHasConnectionFuture = Future.value(true);
        try{
            when(mockDataConnectionChecker.hasConnection).
      thenAnswer((_)  => tHasConnectionFuture);
        // act
        final result =  networkInfo.isConnected;
        // assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, true);
        }catch(e){
          print(e);
        }
      

      }
      );
    });
  }

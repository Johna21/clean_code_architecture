
import 'dart:convert';

import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_code_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client{}

void main(){
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConceretNumberTrivia', (){
    final tNumber = 1;
    final tNumberTriviaModel =
    NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('''should perform a GET request URL with 
    the number being the endpoint and with the application/json''',
     ()async{
      //  arrange
      try {
        when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),headers: anyNamed('headers')))
      .thenAnswer((_) async=> http.Response(fixture('trivia.json'),200));
      
      // act
    dataSource.getConcereteNumberTrivia(tNumber);

      // assert
      verify(mockHttpClient.get(
        Uri.parse('http://numbersapi.com/$tNumber'),
        headers: {
          'Content-Type':'application/json',

        }
      ));
      }catch(e){
        
      }

    }
    );

    
    test('shoud return NumberTrivia when the response is 200 (success)',
     () async{
      // arragne
      try{
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
        headers: anyNamed('headers')
       )).thenAnswer((_) async=> 
       http.Response(fixture('trivia.json'),200)
       );
      // act
  final result = await dataSource.getConcereteNumberTrivia(tNumber);

      // assert
    expect(result, equals(tNumberTriviaModel)); 
      }catch(e){
        
      } 
    });
     
  });
}
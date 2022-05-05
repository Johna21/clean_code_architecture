import 'dart:convert';

import 'package:clean_code_architecture/core/errors/exceptions.dart';
import 'package:clean_code_architecture/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences{}

  void main(){
    late NumberTriviaLocalDataSourceImpl datasource;
    late MockSharedPreferences mockSharedPreferences;

    setUp((){
        mockSharedPreferences = MockSharedPreferences();
        datasource = NumberTriviaLocalDataSourceImpl(
          sharedPreferences: mockSharedPreferences);
    });

    group('getLastNumberTrivia', (){
      
      final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cache.json'))); 
      test('should return NumberTrivia from sharedPreference when there is in a cache',
       () async{
        //  arrange
         when(mockSharedPreferences.getString('any'))
         .thenReturn('trivia_cache.json');
        //  act
        final result = await datasource.getLasNumberTrivia();
        // assert
        verify(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));
        expect(result, equals(tNumberTriviaModel)); 
       });


       test('should throw cache exception when there is cache exception',
       () async{
        //  arrange
         when(mockSharedPreferences.getString(''))
         .thenReturn(null);
        //  act
        final call = await datasource.getLasNumberTrivia;
        // assert
        expect(()=>call(), throwsA(TypeMatcher<CacheException>())); 
       });
    });
    group('cacheNumberTrivia', (){
      final tNumberTriviamodel = NumberTriviaModel(
        text: 'test triva', number: 1);
      test('should call sharedpreferences the data', () async{
      
        //act
            datasource.cacheNumberTrivia(tNumberTriviamodel);
       // assert
       final expectedJson = json.encode(tNumberTriviamodel.toJson());
       verify(mockSharedPreferences.
                        setString(CACHED_NUMBER_TRIVIA,expectedJson));
      });
    });
  }

import 'dart:convert';

import 'package:clean_code_architecture/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource{
  Future<NumberTriviaModel> getLasNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl extends NumberTriviaLocalDataSource {
  
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaCache)  async{
    
    sharedPreferences.setString(
            CACHED_NUMBER_TRIVIA, json.encode(triviaCache.toJson()));

    }

  @override
  Future<NumberTriviaModel> getLasNumberTrivia() async{

    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    return await Future.value(NumberTriviaModel.fromJson(json.decode(jsonString as String)));

    
    
    
  }

}

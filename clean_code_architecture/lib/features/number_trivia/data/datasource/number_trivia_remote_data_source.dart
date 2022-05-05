import 'dart:io';

import 'package:clean_code_architecture/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;

import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource{
  Future<NumberTriviaModel>? getConcereteNumberTrivia( number);
  Future<NumberTriviaModel>? getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl extends NumberTriviaRemoteDataSource {
  
   final http.Client client;
  NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<NumberTriviaModel> getConcereteNumberTrivia(number) {
    client.get(
      Uri.parse('http://numbersapi.com/$number'),
        headers: {
          'Content-Type':'application/json',

        }
    );
    throw CacheException();
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }

}

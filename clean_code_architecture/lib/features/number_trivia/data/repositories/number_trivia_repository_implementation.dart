import 'package:clean_code_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../datasource/number_trivia_local_data_source.dart';
import '../datasource/number_trivia_remote_data_source.dart';



typedef Future<NumberTrivia> _ConcereteRandomChooser();

class NumberTriviaRepositoryImp implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  NumberTriviaRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, NumberTrivia>>? getConcereteNumberTrivia(number)  
    async {
      return await _getTrivia(()=>(remoteDataSource.getConcereteNumberTrivia(number))!);

  }

  @override
  Future<Either<Failure, NumberTrivia>>? getRandomNumberTrivia() async{

           
              return 
              await _getTrivia(()
              {
                
                  return (remoteDataSource.getRandomNumberTrivia())!;
                 
              }
              );
            
            
            


  }

  Future<Either<Failure,NumberTrivia>> _getTrivia(
    _ConcereteRandomChooser getRandomOrConcrete

  ) async{
    
     
    try{
      if(await networkInfo.isConnected!){
         final remoteTrivia = await getRandomOrConcrete();
      localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
      return Right(remoteTrivia);
      }
      else{
        try {
          final localTrivia = await localDataSource.getLasNumberTrivia();
        return Right(localTrivia);
        }
      on CacheException {
        return Left(CacheFailure());
      }
      }
     
    } on ServerException{
      return Left(ServeFailure());
    }
      

  }

}


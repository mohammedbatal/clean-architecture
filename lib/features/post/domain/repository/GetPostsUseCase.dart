import 'package:clean_demo/features/post/data/models/PostEntity_model.dart';
import 'package:clean_demo/features/post/data/repositories/PostRepository.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
}

class GetPostsUseCase
    implements UseCase<Either<ErrorModel, List<PostEntity>>, void> {
  final PostRepository _postRepository;

  GetPostsUseCase({required PostRepository postRepository})
      : _postRepository = postRepository;
  @override
  Future<Either<ErrorModel, List<PostEntity>>> call({void params}) {
    return _postRepository.getPosts.call();
  }
}

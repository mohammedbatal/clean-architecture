// ignore_for_file: file_names
import 'package:clean_demo/features/post/domain/repository/GetPostsUseCase.dart';
import 'package:clean_demo/features/post/domain/usecases/PostEvent.dart';
import 'package:clean_demo/features/post/domain/usecases/PostState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase _getPostsUseCase;

  PostBloc(this._getPostsUseCase) : super(PostInitial()) {
    on<GetPosts>(
      (event, emit) async {
        final result = await _getPostsUseCase.call();

        result.fold((error) {
          emit(PostError(errorMessage: error.errorMessage));
        }, (posts) {
          emit(
            PostSuccess(
              posts: posts,
            ),
          );
        });
      },
    );
  }
}

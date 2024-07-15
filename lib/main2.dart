// // ignore_for_file: public_member_api_docs, sort_constructors_first, overridden_fields, annotate_overrides
// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }

// class PostEntity {
//   final int id;
//   final String title;
//   final String body;

//   PostEntity({
//     required this.id,
//     required this.title,
//     required this.body,
//   });
// }

// class ErrorModel {
//   final String errorMessage;

//   ErrorModel({required this.errorMessage});
// }

// class PostModel extends PostEntity {
//   final int id;
//   final String title;
//   final String body;
//   PostModel({
//     required this.id,
//     required this.title,
//     required this.body,
//   }) : super(
//           id: id,
//           title: title,
//           body: body,
//         );

//   PostModel copyWith({
//     int? id,
//     String? title,
//     String? body,
//   }) {
//     return PostModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       body: body ?? this.body,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'title': title,
//       'body': body,
//     };
//   }

//   factory PostModel.fromMap(Map<String, dynamic> map) {
//     return PostModel(
//       id: map['id'] as int,
//       title: map['title'] as String,
//       body: map['body'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PostModel.fromJson(String source) =>
//       PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'PostModel(id: $id, title: $title, body: $body)';

//   @override
//   bool operator ==(covariant PostModel other) {
//     if (identical(this, other)) return true;

//     return other.id == id && other.title == title && other.body == body;
//   }

//   @override
//   int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode;
// }

// class BaseServcie {
//   final Dio dio;
//   String baseUrl = 'https://jsonplaceholder.typicode.com/posts';
//   late Response response;

//   BaseServcie({required this.dio});
// }

// class PostServcie extends BaseServcie {
//   PostServcie({required super.dio});
//   Future<Response> getPosts() async {
//     response = await dio.get(baseUrl);
//     return response;
//   }
// }

// abstract class PostRepository {
//   Future<Either<ErrorModel, List<PostModel>>> getPosts();
// }

// class PostRespositoryImpl implements PostRepository {
//   final PostServcie _postServcie;

//   PostRespositoryImpl({required PostServcie postServcie})
//       : _postServcie = postServcie;
//   @override
//   Future<Either<ErrorModel, List<PostModel>>> getPosts() async {
//     try {
//       final response = await _postServcie.getPosts();
//       if (response.statusCode == 200) {
//         List<PostModel> posts = List.generate(
//           response.data.length,
//           (index) => PostModel.fromMap(
//             response.data[index],
//           ),
//         );
//         return right(posts);
//       } else {
//         return left(
//           ErrorModel(
//             errorMessage: response.statusMessage.toString(),
//           ),
//         );
//       }
//     } on DioException catch (e) {
//       return left(
//         ErrorModel(
//           errorMessage: e.message.toString(),
//         ),
//       );
//     }
//   }
// }

// abstract class UseCase<Type, Params> {
//   Future<Type> call({Params params});
// }

// class GetPostsUseCase
//     implements UseCase<Either<ErrorModel, List<PostEntity>>, void> {
//   final PostRepository _postRepository;

//   GetPostsUseCase({required PostRepository postRepository})
//       : _postRepository = postRepository;
//   @override
//   Future<Either<ErrorModel, List<PostEntity>>> call({void params}) {
//     return _postRepository.getPosts.call();
//   }
// }

// sealed class PostState {}

// final class PostInitial extends PostState {}

// final class PostLoading extends PostState {}

// final class PostSuccess extends PostState {
//   final List<PostEntity> posts;

//   PostSuccess({required this.posts});
// }

// final class PostError extends PostState {
//   final String errorMessage;

//   PostError({required this.errorMessage});
// }

// sealed class PostEvent {}

// final class GetPosts extends PostEvent {}

// class PostBloc extends Bloc<PostEvent, PostState> {
//   final GetPostsUseCase _getPostsUseCase;

//   PostBloc(this._getPostsUseCase) : super(PostInitial()) {
//     on<GetPosts>(
//       (event, emit) async {
//         final result = await _getPostsUseCase.call();

//         result.fold((error) {
//           emit(PostError(errorMessage: error.errorMessage));
//         }, (posts) {
//           emit(
//             PostSuccess(
//               posts: posts,
//             ),
//           );
//         });
//       },
//     );
//   }
// }

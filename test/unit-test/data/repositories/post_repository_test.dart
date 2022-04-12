import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projecttemplate/core/network/exceptions.dart';
import 'package:projecttemplate/core/network/network_data_manager.dart';
import 'package:projecttemplate/features/data/models/post_model.dart';
import 'package:projecttemplate/features/data/repositories/post_repository.dart';

void main() {
  final PostRepository postRepository = PostRepository(
    NetworkDataManager(
      Dio(),
    ),
  );

  test(
    'fetch posts and return [Post] if its success',
    () async {
      final response = await postRepository.fetchPosts();
      expect(response is Right<ServerException, List<Post>>, true);
    },
  );
}

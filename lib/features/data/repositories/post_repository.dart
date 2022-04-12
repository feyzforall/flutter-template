import 'package:dartz/dartz.dart';

import '../../../core/constants/endpoints.dart';
import '../../../core/network/exceptions.dart';
import '../../../core/network/network_data_manager.dart';
import '../models/post_model.dart';

abstract class IPostRepository {
  Future<Either<ServerException, List<Post>>> fetchPosts();
}

class PostRepository extends IPostRepository {
  final NetworkDataManager networkDataManager;

  PostRepository(this.networkDataManager);
  @override
  Future<Either<ServerException, List<Post>>> fetchPosts() async {
    try {
      final response = await networkDataManager.get(Endpoints.posts);
      final posts = (response.data as List).map((e) => Post.fromJson(e)).toList();
      return Right(posts);
    } on ServerException catch (err) {
      return Left(err);
    }
  }
}

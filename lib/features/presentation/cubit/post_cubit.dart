import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/post_model.dart';
import '../../data/repositories/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postRepository) : super(PostInitial());

  final PostRepository postRepository;

  Future<void> getPosts() async {
    emit(PostLoading());
    final response = await postRepository.fetchPosts();
    response.fold(
      (l) => emit(PostError()),
      (r) => emit(PostLoaded(r)),
    );
  }
}

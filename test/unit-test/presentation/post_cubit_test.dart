import 'package:dio/dio.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projecttemplate/core/network/network_data_manager.dart';
import 'package:projecttemplate/features/data/repositories/post_repository.dart';
import 'package:projecttemplate/features/presentation/cubit/post_cubit.dart';

void main() {
  final PostCubit postCubit = PostCubit(
    PostRepository(
      NetworkDataManager(
        Dio(),
      ),
    ),
  );

  blocTest<PostCubit, PostState>(
    'emits [PostLoading], [PostLoaded] when getPosts called',
    build: () => postCubit,
    act: (bloc) async => await postCubit.getPosts(),
    expect: () => [
      isA<PostLoading>(),
      isA<PostLoaded>(),
    ],
  );
}

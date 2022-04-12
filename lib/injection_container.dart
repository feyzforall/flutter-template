import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_data_manager.dart';
import 'features/data/repositories/post_repository.dart';
import 'features/presentation/cubit/post_cubit.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerFactory(
    () => PostCubit(
      PostRepository(
        NetworkDataManager(
          Dio(),
        ),
      ),
    ),
  );
}

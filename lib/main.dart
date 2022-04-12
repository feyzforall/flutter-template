import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/presentation/cubit/post_cubit.dart';
import 'injection_container.dart' as injector;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injector.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>(
          create: (context) => injector.getIt.get<PostCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

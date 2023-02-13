import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'ui/ui.dart';
import 'utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddNewTodoListCubit>(
            create: (context) => AddNewTodoListCubit()),
        BlocProvider<ReadTodoListCubit>(
            create: (context) => ReadTodoListCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: Routes.routes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Page1Screen(),
      ),
    );
  }
}

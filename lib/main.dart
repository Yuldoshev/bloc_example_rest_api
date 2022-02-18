import 'package:bloc_app/bloc/home_bottom_nav_cubit.dart';
import 'package:bloc_app/bloc/user_bloc.dart';
import 'package:bloc_app/presetation/ui/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeTab.routName,
      routes: routes,
    );
  }
}

final routes = <String, WidgetBuilder>{
  HomeTab.routName: (context) => MultiBlocProvider(providers: [
        BlocProvider(create: (context) => HomeBottomNavIndexBloc()),
        BlocProvider(create: (context) => UserBloc()),
      ], child: const HomeTab())
};

import 'package:e_commerce/app/theme/colors.dart';
import 'package:e_commerce/presentation/cart_screen.dart/bloc/bloc/cart_bloc_bloc.dart';
import 'package:e_commerce/presentation/home_screen/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/di/service_locator.dart';

void main() {
  serviceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce - demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: whiteClr),
      home: HomeScreen(),
    );
  }
}

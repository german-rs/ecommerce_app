import 'package:ecommerce_app/bloc/ecommerce_bloc.dart';
import 'package:ecommerce_app/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    BlocProvider(
      create: (context) => EcommerceBloc(),
      child: const MaterialApp(
        home: MainView(),
      ),
    ),
  );
}

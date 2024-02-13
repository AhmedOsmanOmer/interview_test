import 'package:flutter/material.dart';
import 'package:interview_test/bloc/data_blocc.dart';
import 'package:interview_test/view/data_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = DataBloc();

    return MaterialApp(
      title: 'CRUD App',
      home: DataView(bloc: bloc),
    );
  }
}

import 'package:interview_test/model/user_data.dart';

enum DataState {
  loading,
  loaded,
  error,
}

class DataViewState {
  final DataState state;
  final List<Data>? data;
  final String? error;

  DataViewState({
    required this.state,
    this.data,
    this.error,
  });
}

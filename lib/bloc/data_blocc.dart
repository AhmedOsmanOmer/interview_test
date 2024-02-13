import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:interview_test/bloc/data_state.dart';
import 'package:interview_test/constant.dart';
import 'package:interview_test/model/user_data.dart';

class DataBloc {
  final _dataController = StreamController<DataViewState>();
  Stream<DataViewState> get dataStream => _dataController.stream;

  Future<void> fetchData() async {
    try {
      _dataController.add(DataViewState(state: DataState.loading));
      final response = await http.get(Uri.parse(readUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        final dataList = jsonData
            .map((item) => Data(
                  id: item['id'],
                  title: item['title'],
                  email: item['email'],
                  description: item['description'],
                  imgLink: item['img_link'],
                ))
            .toList();
        _dataController.add(DataViewState(state: DataState.loaded, data: dataList));
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      _dataController.add(DataViewState(state: DataState.error, error: e.toString()));
    }
  }

Future<void> deleteData(int id, String email) async {
    final response =
        await http.delete(Uri.parse('$deleteUrl+email=$email&id=$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  Future<void> updateData(String email, int id, String title, String img_link,
      String description) async {
    final response = await http.put(
        Uri.parse(
            '$editUrl+email=$email&id=$id&title=$title&img_link=$img_link&description=$description'));
    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
  }

  Future<void> addData(String email, String title, String img_link,
      String description) async {
    final response = await http.post(
      Uri.parse(
          "$addUrl+email=$email&title=$title&img_link=$img_link&description=$description"),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add data');
    }
  }
  void dispose() {
    _dataController.close();
  }
}

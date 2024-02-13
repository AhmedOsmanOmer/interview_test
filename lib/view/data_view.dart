import 'package:flutter/material.dart';
import 'package:interview_test/bloc/data_blocc.dart';
import 'package:interview_test/bloc/data_state.dart';
import 'package:interview_test/view/add_user.dart';
import 'package:interview_test/view/update_user.dart';

class DataView extends StatefulWidget {
  final DataBloc bloc;

  const DataView({Key? key, required this.bloc}) : super(key: key);

  @override
  _DataViewState createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  @override
  void initState() {
    super.initState();
    widget.bloc.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data List'),
      ),
      body: StreamBuilder<DataViewState>(
        stream: widget.bloc.dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final state = snapshot.data!;
            if (state.state == DataState.loaded) {
              return ListView.builder(
                itemCount: state.data!.length,
                itemBuilder: (context, index) {
                  final item = state.data![index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.email),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateUser(
                            bloc: widget.bloc,
                            email: item.email,
                            id: item.id,
                            title: item.title,
                            img_link: item.imgLink,
                            description: item.description,
                          ),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        widget.bloc.deleteData(item.id, "mikehsch@gmail.com");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data deleted successfully'),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state.state == DataState.error) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUser(bloc: widget.bloc),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

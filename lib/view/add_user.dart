import 'package:flutter/material.dart';
import 'package:interview_test/bloc/data_blocc.dart';

class AddUser extends StatefulWidget {
  final DataBloc bloc;

  const AddUser({Key? key, required this.bloc}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController imgLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: imgLinkController,
              decoration: const InputDecoration(labelText: 'Image Link'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addUser();
              },
              child: const Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }

  void _addUser() {
    final String title = titleController.text;
    final String description = descriptionController.text;
    final String email = emailController.text;
    final String imgLink = imgLinkController.text;

    if (title.isEmpty ||
        description.isEmpty ||
        email.isEmpty ||
        imgLink.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    widget.bloc.addData(email, title, imgLink, description);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data added successfully'),
      ),
    );

    Navigator.pop(context);
  }
}

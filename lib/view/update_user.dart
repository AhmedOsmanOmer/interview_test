import 'package:flutter/material.dart';
import 'package:interview_test/bloc/data_blocc.dart';

class UpdateUser extends StatefulWidget {
  final DataBloc bloc;
  final String email;
  final int id;
  final String title;
  final String img_link;
  final String description;

  const UpdateUser({
    Key? key,
    required this.bloc,
    required this.email,
    required this.id,
    required this.title,
    required this.img_link,
    required this.description,
  }) : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController imgLinkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    emailController.text = widget.email;
    idController.text = widget.id.toString();
    imgLinkController.text = widget.img_link;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: idController,
              enabled: false, // Disable editing of ID
              decoration: const InputDecoration(labelText: 'ID'),
            ),
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
                _updateUser();
              },
              child: const Text('Update User'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUser() {
    final String title = titleController.text;
    final String description = descriptionController.text;
    final String email = emailController.text;
    final String imgLink = imgLinkController.text;
    final int id = int.tryParse(idController.text) ?? 0;

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

    widget.bloc.updateData(email, id, title, imgLink, description);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data updated successfully'),
      ),
    );

    Navigator.pop(context);
  }
}

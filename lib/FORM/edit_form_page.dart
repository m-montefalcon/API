import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditForm extends StatefulWidget {
  final dynamic mr;

  const EditForm({required this.mr, Key? key}) : super(key: key);

  @override
  State<EditForm> createState() => _EditForm();
}

const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

class _EditForm extends State<EditForm> {
  TextEditingController title = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var id = '';
  var check;

  @override
  void initState() {
    super.initState();
    title.text = widget.mr["title"];
    id = widget.mr["id"].toString();
    check = widget.mr["title"];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Edit Todo"),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(40.0),
            children: [
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                    labelText: "Todo Title",
                    hintText: "E.g Do Chores"
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter todo title';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (check != title.text){
                          await editUser();
                          Navigator.pop(context,check);
                        }else{
                          return null;
                        }
                      }else{
                        return null;
                      }
                    },
                    child: const Text('Done')),
              ),
            ],
          ),
        ));
  }
  editUser() async {
    var newTitle = title.text;
    var url = Uri.parse('$baseUrl/$id');
    var bodyData = json.encode({
      'title': newTitle,
    });
    var response = await http.patch(url, body: bodyData);
    if (response.statusCode == 200) {
      print('\nSuccessfully edited ToDo id: $id!');

    } else {
      return null;
    }
  }

}
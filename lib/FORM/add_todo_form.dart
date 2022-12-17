import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../MODELS/model.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}
var formKey = GlobalKey<FormState>();


const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

Future<TodoModel?> submitData(String title, bool status) async {
  var url = Uri.parse(baseUrl);
  var bodyData = json.encode({'title': title, 'completed': status});
  var response = await http.post(url, body: bodyData);

  if (response.statusCode == 201) {
    print('Successfully added ToDo!');


    String todoResponse = response.body;
    todoModelFromJson(todoResponse);
  } else {
    return null;
  }
}

TodoModel? todoModel;

class _TodoFormState extends State<TodoForm> {


  TextEditingController todoTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Form(
        key:formKey,
          child: ListView(
            padding: EdgeInsets.all(30),
            children: [
              TextFormField(
                controller: todoTitleController,
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
                        TodoModel? data = await submitData(todoTitleController.text, false);
                        setState(() {
                          todoModel = data;
                        });
                      } else {
                        return null;
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Add Todo")
                )

              )
            ],
          )
      ),
    );

  }

}




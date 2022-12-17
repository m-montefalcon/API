import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/FORM/add_todo_form.dart';

import 'package:http/http.dart' as http;
import 'package:todo_list/FORM/edit_form_page.dart';
import 'details_page.dart';



class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    getTodo();
    super.initState();
  }

  List mapResponse = <dynamic>[];
  @override



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.code_rounded),
        title: const Text("Todo with API"),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(50.00),
          itemCount :  mapResponse.length,
          itemBuilder: (context, index){
            return ListTile(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>DetailsPage(mr: mapResponse[index])

                    )
                );
              },

              trailing: Wrap(
                children: [
                  
                  IconButton(
                      onPressed: () async {
                        var check = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditForm(mr: mapResponse[index])));

                      },
                      icon: Icon(Icons.edit)),
                  
                  IconButton(
                      onPressed: (){
                        setState(() {
                          deleteTodo(mapResponse[index]);
                          mapResponse.removeAt(index);
                        });
                      },

                      icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                      )
                  )
                ],
              ),
              leading: Text(mapResponse[index]['id'].toString()),
              title: Text(mapResponse[index]['title']),
              subtitle: const Text("Tap to see details"),



            );
    }
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> TodoForm()
                )
            );
          },
          label: Text("Add Todo"),
      ),
    );
  }

  getTodo() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body) as List<dynamic>;
      });
    } else {
      return null;
    }
  }

  deleteTodo(var object) async {
    var url = Uri.parse('$baseUrl/${object["id"]}');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      print('Successfully deleted ToDo: ${object["title"]} ID: ${object["id"]}');
    } else {
      return null;
    }
  }
}

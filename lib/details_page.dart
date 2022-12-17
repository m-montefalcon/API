import 'package:flutter/material.dart';
import 'package:todo_list/FORM/edit_form_page.dart';


class DetailsPage extends StatefulWidget {
  final dynamic mr;
  const DetailsPage({
    required this.mr,
    Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget rowItem(String title, dynamic value) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(title),
        ),
        const SizedBox(width: 5),
        Text(value.toString())
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Details"),
      ),
      body: ListView(
        padding: EdgeInsets.all(50),
        children: [
          rowItem("Title", widget.mr["title"]),
          rowItem("Completed", widget.mr["completed"]),
          SizedBox(height: 20),
        ],
      ),


    );
  }
}

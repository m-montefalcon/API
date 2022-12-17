import 'package:flutter/material.dart';

import 'my_home.dart';

void main() => runApp(
    MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const MyHome() //this is my home page or page one
    )
);
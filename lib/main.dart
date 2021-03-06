import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:team_gp/Screens/Admin/category/edit.dart';
import 'package:team_gp/Screens/Admin/product/edit.dart';
import 'Screens/Admin/product/list.dart';
import 'Screens/Login/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        EditProduct.id: (context) => EditProduct(),
      },
      theme: ThemeData(
        primaryColor: Colors.blueGrey[600],
        cursorColor: Colors.blueGrey[600],
      ),
      home: Login(),
    );
  }
}

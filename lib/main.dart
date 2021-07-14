import 'package:contacts_2/Services/ContactService.dart';
import 'package:contacts_2/Views/GetContact.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


void setupLocator(){
  GetIt.instance.registerLazySingleton(() => ContactService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: GetContact(),
      debugShowCheckedModeBanner: false,
    );
  }
}



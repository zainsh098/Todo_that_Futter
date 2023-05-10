import 'package:flutter/material.dart';

import 'package:todo_that/utils/route_name.dart';
import 'package:todo_that/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo ',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        
      ),
      initialRoute: RouteName.splash_screen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}


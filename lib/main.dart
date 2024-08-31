import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kundan_practical/module/controller/product_controller.dart';
import 'package:kundan_practical/module/view/home/home_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MultiProvider(
       providers: [
         ChangeNotifierProvider(create:(context)=> ProductController())
       ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

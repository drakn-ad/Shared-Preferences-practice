import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared preferences"),
        actions: [],
      ),
      body: ListView(
        children: [
          MaterialButton(onPressed: ()async{
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString('name', 'adham');
          }, child: Text("set name"),),
          MaterialButton(onPressed: ()async{
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            String name = sharedPreferences.getString('name')!;    
            print(name);       
          }, child: Text("print name"),),
        ],
      ),
    );
  }
}
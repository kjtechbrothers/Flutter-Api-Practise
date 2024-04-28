import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/user_model.dart';
class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList=[];
  Future<List<UserModel>> getUserApi () async{
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else {
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api Course'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getUserApi (), builder: (context, snapshot) {
              if(!snapshot.hasData){
                return const Text('Loading');
              }
              else{
                return ListView.builder(
                  itemCount: userList.length,
                    itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        const Text('Name', style: TextStyle(color: Colors.blue,fontSize: 15),),
                        Text(snapshot.data![index].name.toString()),
                        const Text('Address', style: TextStyle(color: Colors.blue,fontSize: 15),),
                        Text(snapshot.data![index].address.toString()),
                        const Text('Email', style: TextStyle(color: Colors.blue,fontSize: 15),),
                        Text(snapshot.data![index].email.toString()),
                        const Text('Phone', style: TextStyle(color: Colors.blue,fontSize: 15),),
                        Text(snapshot.data![index].phone.toString()),
                      ],
                    ),
                  );
                });
              }

            }),
          )
        ],
      ),
    );
  }
}

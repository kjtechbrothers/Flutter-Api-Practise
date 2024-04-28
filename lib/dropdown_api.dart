import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;

import 'package:flutter/material.dart';
import 'package:untitled9/dropdown_api.dart';

import 'Models/dropdown_model.dart';
class DropdownApi extends StatefulWidget {
  const DropdownApi({super.key});

  @override
  State<DropdownApi> createState() => _DropdownApiState();
}

class _DropdownApiState extends State<DropdownApi> {
  Future<List<DropdownModel>> getPost()async{

    try{
      final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      final body=jsonDecode(response.body) as List;{
        if(response.statusCode==200){
          return body.map((e) {
            final map= e as Map<String,dynamic>;
            return DropdownModel(
              userId: map['userId'],
              id: map['id'],
              title: map['title'],
              body: map['body'],
            );
          }).toList();

        }

      }

    }
    on SocketException{
      throw Exception('No internet');
    }
    throw Exception('Error in data fetching');
  }
  var selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Center(child: Text('Dropdown Api')),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(future: getPost(), builder: (context,snapshot){
            if(snapshot.hasData){
              return DropdownButton(
                  hint: const Text('Select value'),
                  isExpanded: true,
                  value: selectedValue,
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  items: snapshot.data!.map((e) {
                    return DropdownMenuItem(
                      value: e.title.toString(),
                        child: Text(e.title.toString())
                    );
                  }).toList(),

                  onChanged: (value){
                    selectedValue =value;
                    setState(() {

                    });
                  });
            }else{
              return const CircularProgressIndicator();
            }
          })
          
        ],
      ),
    );
  }
}

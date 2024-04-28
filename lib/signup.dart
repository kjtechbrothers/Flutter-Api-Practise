

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  void login(String email,password)async{
    try{
      Response response=await post(Uri.parse('https://reqres.in/api/login'),
      body: {
        'email' : email,
        'password' : password,
      }
      );
      if(response.statusCode==200){
        var data=jsonDecode(response.body.toString());
        print(data);
        print('Login successfully');
      }
      else{
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login Api'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(),passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child:Text('Login')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

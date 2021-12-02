import 'package:aman_firebase/Pages/update_student_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);



  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey=GlobalKey<FormState>();
  var name="";
  var email="";
  var password="";
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  clearText(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  CollectionReference student=FirebaseFirestore.instance.collection('student');
  Future<void> addUser(){
    return student.add({'name':name,'email':email,'password':password});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Add new Student'),
      ),
      body: Form(
        key: _formKey,
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
          child:ListView(
            children: [
              Container(
                margin:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child:TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                      TextStyle(color: Colors.red,fontSize: 15)
                  ),
                  controller: nameController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter Name';
                    }
                    return null;
                  }
                )
              ),
              Container(
                  margin:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  child:TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.red,fontSize: 15)
                      ),
                      controller: emailController,
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please Enter Email';
                        }
                        return null;
                      }
                  )
              ),
              Container(
                  margin:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  child:TextFormField(
                      autofocus: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.red,fontSize: 15)
                      ),
                      controller: passwordController,
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please Enter Password';
                        }
                        return null;
                      }
                  )
              ),
              const SizedBox(height: 8.0,),
              Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: () {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          name=nameController.text;
                          email=emailController.text;
                          password=passwordController.text;
                          addUser();
                          clearText();
                        });
                      }

                    },
                        child:const Text(
                          'Register',
                          style: TextStyle(fontSize: 18.0),
                        ),
                    ),
                    ElevatedButton(onPressed: () {

                     clearText();
                    },
                        child:const Text(
                          'Reset',
                          style: TextStyle(fontSize: 18.0,),
                        ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    )
                  ],
                )
              )
            ],
          )
        ),
      ),
    );

  }
}

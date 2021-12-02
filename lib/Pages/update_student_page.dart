import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
  const UpdateStudentPage({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  CollectionReference student =
      FirebaseFirestore.instance.collection('student');
  Future<void>updateUser(String id,name,email,password) {
    return student.doc(id)
        .update({'name':name,'email':email,'password':password});
  }
  dataReset() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Data'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('student')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something went worng');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              Map<String,dynamic> data=snapshot.data!.data();
              var name=data!['name'];
              var email=data['email'];
              var password=data['password'];
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: ListView(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: TextFormField(
                              initialValue:name,
                              autofocus: false,
                              onChanged: (value) => name=value,
                              decoration: const InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(fontSize: 20.0),
                                  border: OutlineInputBorder(),
                                  errorStyle: TextStyle(
                                      color: Colors.red, fontSize: 15)),
                              // controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Name';
                                }
                                return null;
                              })),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: TextFormField(
                              initialValue: email,
                              autofocus: false,
                              onChanged: (value) => email=value,
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(fontSize: 20.0),
                                  border: OutlineInputBorder(),
                                  errorStyle: TextStyle(
                                      color: Colors.red, fontSize: 15)),
                              // controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                } else if (!value.contains('@')) {
                                  return 'Please Enter Valid Value';
                                }
                                return null;
                              })),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: TextFormField(
                              initialValue: password,
                              autofocus: false,
                              onChanged: (value) => password=value,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(fontSize: 20.0),
                                  border: OutlineInputBorder(),
                                  errorStyle: TextStyle(
                                      color: Colors.red, fontSize: 15)),
                              // controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Password';
                                }
                                return null;
                              })),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                updateUser(widget.id,name,
                                    email,password);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "Update",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {dataReset()},
                            child: const Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey),
                          )
                        ],
                      )
                    ],
                  ));

              //last Bracket start from here
            }),
      ),
    );
  }
}

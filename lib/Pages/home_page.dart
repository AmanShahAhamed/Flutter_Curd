import 'package:flutter/material.dart';
import 'add_student_page.dart';
import 'list_student_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            const Text('Flutter Firestore Crud'),
            ElevatedButton(
              onPressed: ()=>{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>AddStudentPage()
                  ),
                )
              },
              child: const Text('Add',style: TextStyle(fontSize: 20.0),),
              style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            ),
          ],
        ),
      ),
      body: ListStudentPage(),
    );
  }
}

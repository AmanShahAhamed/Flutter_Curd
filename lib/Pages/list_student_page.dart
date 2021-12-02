
import 'package:aman_firebase/Pages/update_student_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentStream =
      FirebaseFirestore.instance.collection('student').snapshots();

CollectionReference student=FirebaseFirestore.instance.collection('student');

  @override
  
  
  Widget build(BuildContext context) {
    
   Future<void> deleteUser(id){
      
      return student
          .doc(id)
          .delete();
    }
    return StreamBuilder(
        stream: studentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List storedoc = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data();
            storedoc.add(a);
            a['id']=document.id;
          }).toList();

          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Container(
                          color: Colors.greenAccent,
                          child: const Center(
                              child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                    ),
                    TableCell(
                      child: Container(
                          color: Colors.greenAccent,
                          child: const Center(
                              child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                    ),
                    TableCell(
                      child: Container(
                          color: Colors.greenAccent,
                          child: const Center(
                              child: Text(
                            'Action',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                    ),
                  ]),
                  for(var i=0;i<storedoc.length;i++) ...[
                  TableRow(children: [
                     TableCell(
                        child: Center(
                            child: Text(
                              storedoc[i]['name'],
                      style: const TextStyle(fontSize: 18.0),

                    ))),
                     TableCell(
                        child: Text(
                       storedoc[i]['email'],
                      style: const TextStyle(fontSize: 18.0),
                    )),
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateStudentPage(
                                              id:storedoc[i]['id']
                                            ),
                                      ),
                                    )
                                  },
                              icon:
                                  const Icon(Icons.edit, color: Colors.orange)),
                          IconButton(
                            onPressed: () => {
                              deleteUser(storedoc[i]['id'])
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),],
                ],
              ),
            ),
          );
        });
  }
}

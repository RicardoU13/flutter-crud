import 'package:app_flutter_crud/screens/view_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  late DatabaseReference _ref;
  // ignore: prefer_final_fields
  TextEditingController _taskController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _ref = FirebaseDatabase.instance.ref().child("Tasks");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Publicar Tareas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _taskController,
                    decoration: const InputDecoration(hintText: "Ingrese la tarea"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Ingrese una tarea";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  // ignore
                  ElevatedButton(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      _formkey.currentState!.save();
                      _ref.push().set(_taskController.text).then((value) =>
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewData())));
                    },
                    child: const Text('Publicar'),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

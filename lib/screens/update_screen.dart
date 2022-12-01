//ignore_for_file: deprecated_member_use, prefer_final_fields,
//ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app_flutter_crud/screens/view_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String value;
  // ignore: use_key_in_widget_constructors
  const UpdateScreen({required this.value});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _textController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _ref = FirebaseDatabase.instance.ref().child("Tasks");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar Tarea"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textController,
                    decoration:
                        const InputDecoration(hintText: "Ingrese valor actualizado para Tarea"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Ingrese un valor actualizado para la Tarea";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      _formkey.currentState!.save();
                      String _text = _textController.text;
                      _ref.child(widget.value).set(_text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewData()));
                    },
                    child: const Text("Actualizar"),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

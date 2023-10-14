import 'package:flutter/material.dart';
import 'package:todo_app/task.dart';

// ignore: must_be_immutable
class AddTask extends StatelessWidget {
  AddTask({super.key, required this.onAddTap});
  final Function(Todo) onAddTap;
  TextEditingController todoEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: globalKey,
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Add new todo"),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: todoEditingController,
                decoration: const InputDecoration(
                  hintText: "Enter your todo",
                ),
                // validator: (String?value){
                //   if (value?.isEmpty??true) {
                //     return "Enter a value";
                //   }
                //   return null;
                // },
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        Todo todo = Todo(
                            details: todoEditingController.text.trim(),
                            createDateTime: DateTime.now(),
                            updateDateTime: DateTime.now());
                        onAddTap(todo);
                      }
                    },
                    child: const Text("Add")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

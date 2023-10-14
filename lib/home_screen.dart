import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/addTask.dart';
import 'package:todo_app/task.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();

  List<Todo> taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
              context: context,
              builder: (context) => AddTask(onAddTap: (Todo task) {
                    addTask(task);
                  }));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            final Todo todo = taskList[index];
            final String formateDate =
                DateFormat("hh:MM a day-MM-YY").format(todo.createDateTime);
            return ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Actions"),
                          content: Wrap(
                            children: [
                              ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text("Edit Todo"),
                                            content: Wrap(
                                              children: [
                                                TextFormField(
                                                  controller:
                                                      textEditingController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "Update",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                      onPressed: () {},
                                                      child:
                                                          const Text("Update")),
                                                )
                                              ],
                                            ),
                                          ));
                                },
                                title: const Text("Edit"),
                                leading: const Icon(Icons.edit),
                              ),
                               ListTile(
                                onTap: (){
                                  setState(() {
                                    deleteTodo(index);
                                  });
                                },
                                title: Text("Delete"),
                                leading: Icon(Icons.delete),
                              )
                            ],
                          ),
                        ));
              },
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(todo.details),
              subtitle: Text(formateDate),
              trailing: Text(todo.status.toUpperCase()),
            );
          }),
    );
  }

  void addTask(Todo task) {
    taskList.add(task);
    setState(() {});
  }

  void deleteTodo(int index) {
    taskList.removeAt(index);
    setState(() {});
  }

  void updateTodo(int index, String todoDetails) {
    taskList[index].details = todoDetails;
    setState(() {});
  }
  void updateTodoStatus(int index, String status) {
    taskList[index].status = status;
    setState(() {});
  }
}

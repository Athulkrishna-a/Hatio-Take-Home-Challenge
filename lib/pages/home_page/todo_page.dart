// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_webapp/services/firebase_services.dart';
import 'package:todo_webapp/utils/colors.dart';
import 'package:todo_webapp/widgets/export_data.dart';

class TodoView extends StatelessWidget {
  final String projectId;
  final String projectTitle;

  TodoView({required this.projectId, required this.projectTitle});
  final FirebaseService _auth = FirebaseService();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleUpadateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Text(
                  "TODO LIST",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close_rounded),
                    ),
                    Text(
                      projectTitle,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var snapshot = await _auth.getTodos(projectId).first;
                        var todos = snapshot.docs
                            .map((doc) => {
                                  'description': doc['description'],
                                  'status': doc['status'],
                                  'createdDate':
                                      doc['createdDate'].toDate().toString(),
                                  'updatedDate':
                                      doc['updatedDate'].toDate().toString(),
                                })
                            .toList();

                        int totalTodos = todos.length;
                        int completedTodos = todos
                            .where((todo) => todo['status'] == 'done')
                            .length;

                        await exportToGist(
                            projectTitle, completedTodos, totalTodos, todos);
                      },
                      child: const Text('Export Summary'),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Add Todo'),
                              content: TextField(
                                  controller: descriptionController,
                                  decoration: const InputDecoration(
                                      labelText: 'Description')),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      _auth.addTodo(projectId,
                                          descriptionController.text);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Add Todo')),
                              ],
                            );
                          },
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          Text(
                            "Add Todo ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Todo Task",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Created Date",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Updated Date",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Todo Status",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Mark as Completed",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //
              Expanded(
                child: StreamBuilder(
                  stream: _auth.getTodos(projectId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var todos = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        var todo = todos[index];
                        return Container(
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  todo['description'],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  '${todo['createdDate'].toDate()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${todo['updatedDate'].toDate()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${todo['status']}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _auth.updateTodoStatus(
                                        projectId, todo.id, 'done');
                                  },
                                  child: const Icon(
                                    Icons.mark_as_unread_rounded,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Edit Todo Task'),
                                          content: TextField(
                                            controller: titleUpadateController,
                                            decoration: const InputDecoration(
                                                labelText: 'Description'),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('Cancel')),
                                            TextButton(
                                              onPressed: () async {
                                                await _auth.updateTodoTitle(
                                                    projectId,
                                                    todo.id,
                                                    titleUpadateController
                                                        .text);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Update'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit_document,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _auth.deleteTodo(projectId, todo.id);
                                  },
                                  child: const Icon(
                                    Icons.delete_rounded,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

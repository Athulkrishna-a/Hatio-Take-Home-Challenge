// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_webapp/pages/home_page/todo_page.dart';
import 'package:todo_webapp/services/firebase_services.dart';
import 'package:todo_webapp/utils/colors.dart';
import 'package:todo_webapp/widgets/signin_box.dart';

class ProjectBox extends StatefulWidget {
  const ProjectBox({super.key});

  @override
  State<ProjectBox> createState() => _ProjectBoxState();
}

class _ProjectBoxState extends State<ProjectBox> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController titleUpadateController = TextEditingController();
  final FirebaseService _auth = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Welcome, Hatio!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 150,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    "Hatio:Take Home Challenge",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 200,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Add Project'),
                            content: TextField(
                                controller: _titleController,
                                decoration:
                                    const InputDecoration(labelText: 'Title')),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () {
                                    _auth.addProject(
                                      _titleController.text,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Add')),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add projects"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await _auth.signOut().then((value) => Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const SignIn())));
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("LogOut"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _auth.getProjects(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                var projects = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: GridView.builder(
                    itemCount: projects.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: (40 / 10),
                    ),
                    itemBuilder: (context, index) {
                      var project = projects[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: TodoView(
                                    projectId: project.id,
                                    projectTitle: project['title']),
                              ));
                        },
                        child: Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: AppColors.secondaryColor,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project['title'],
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'ID: ${project.id}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color.fromARGB(202, 27, 26, 26),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Created: ${project['createdDate'].toDate()}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color.fromARGB(206, 27, 26, 26),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Edit Todo Task'),
                                              content: TextField(
                                                controller:
                                                    titleUpadateController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Description'),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                  onPressed: () async {
                                                    await _auth
                                                        .updateProjectTitle(
                                                            project.id,
                                                            titleUpadateController
                                                                .text);
                                                    // ignore: use_build_context_synchronously
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      style: const ButtonStyle(),
                                      onPressed: () {
                                        _auth.deleteProject(project.id);
                                      },
                                      child: const Icon(
                                        Icons.delete_forever_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

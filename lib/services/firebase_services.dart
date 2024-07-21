import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> addProject(String title) async {
    User? user = await getCurrentUser();
    if (user != null) {
      await _firestore.collection('projects').add({
        'title': title,
        'userId': user.uid,
        'createdDate': Timestamp.now(),
      });
    }
  }

  Stream<QuerySnapshot> getProjects() {
    return _firestore.collection('projects').snapshots();
  }

  Future<void> updateProjectTitle(String projectId, String title) async {
    await _firestore.collection('projects').doc(projectId).update({
      'title': title,
    });
  }

  Future<void> deleteProject(String projectId) async {
    await _firestore.collection('projects').doc(projectId).delete();
  }

  Future<void> addTodo(String projectId, String description) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .add({
      'description': description,
      'status': 'incomplete',
      'createdDate': Timestamp.now(),
      'updatedDate': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getTodos(String projectId) {
    return _firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .snapshots();
  }

  Future<void> updateTodoStatus(
      String projectId, String todoId, String status) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .doc(todoId)
        .update({
      'status': status,
      'updatedDate': Timestamp.now(),
    });
  }

  Future<void> deleteTodo(String projectId, String todoId) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .doc(todoId)
        .delete();
  }

  Future<void> updateTodoTitle(
      String projectId, String todoId, String description) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('todos')
        .doc(todoId)
        .update({
      'description': description,
      'updatedDate': Timestamp.now(),
    });
  }
}

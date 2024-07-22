# Hatio : Take Home Challenge

This is a Flutter application that helps users manage their projects and todos. The app allows users to create and manage projects, add todos to each project, and perform various actions such as marking todos as done, updating or deleting them. The application uses Firebase for authentication and Firestore for data storage.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Tools and Libraries 

- **Flutter**: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Firebase**: A platform developed by Google for creating mobile and web applications.
  - **Firebase Auth**: Used for user authentication.
  - **Cloud Firestore**: A flexible, scalable database for mobile, web, and server development.
- **http**: A package for making HTTP requests.

### Prerequisites

Before you begin, ensure you have met the following requirements:

- **Flutter SDK**: Install the Flutter SDK from [here](https://flutter.dev/docs/get-started/install).
- **Firebase Project**: Create a Firebase project from the [Firebase Console](https://console.firebase.google.com/).
- **Git**: Ensure you have Git installed on your machine. You can download it from [here](https://git-scm.com/downloads).

### Firebase Setup

1. **Create Firebase Project**:
   - Go to the [Firebase Console](https://console.firebase.google.com/).
   - Click on **Add Project** and follow the prompts to create a new Firebase project.

2. **Add Firebase to Your Flutter App**:
   - Click on the Android icon to add Firebase to your Android app.
   - Follow the instructions to download the `google-services.json` file.
   - Place the `google-services.json` file in the `android/app` directory of your Flutter project.

3. **Add Firebase SDK**:
   - Add the following dependencies in your `pubspec.yaml` file:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       firebase_core: latest_version
       firebase_auth: latest_version
       cloud_firestore: latest_version
       http: latest_version
     ```
   - Run `flutter pub get` to install the dependencies.

4. **Initialize Firebase**:
   - Add Firebase initialization code in your `main.dart` file:
     ```dart
     import 'package:firebase_core/firebase_core.dart';
     import 'package:flutter/material.dart';

     void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await Firebase.initializeApp();
       runApp(MyApp());
     }

     class MyApp extends StatelessWidget {
       @override
       Widget build(BuildContext context) {
         return MaterialApp(
           title: 'Hatio Notes',
           theme: ThemeData(
             primarySwatch: Colors.blue,
           ),
           home: MyHomePage(),
         );
       }
     }
     ```

### Build and Run the Project

1. **Clone the Repository**:
   - Open your terminal or command prompt.
   - Run the following command to clone the repository:
     ```bash
     git clone https://github.com/yourusername/hatio-notes.git
     ```
   - Navigate to the project directory:
     ```bash
     cd todo_webapp
     ```

2. **Install Dependencies**:
   - Ensure you have all dependencies installed by running:
     ```bash
     flutter pub get
     ```

3. **Run the App**:
   - Connect your mobile device or start an emulator.
   - Run the following command to start the app:
     ```bash
     flutter run
     ```

### Additional Information

- **Firebase Authentication**:
  - The app uses Firebase Authentication for user registration and login.
  - Make sure you have enabled the necessary authentication methods in the Firebase Console.

- **Firestore Database**:
  - The app uses Cloud Firestore to store project and todo data.
  - Ensure you have configured Firestore rules to secure your data appropriately.

For more details on Flutter and Firebase, refer to the official documentation:
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
![350775796-3ed0277e-6349-449a-a65a-897077c5c1d0](https://github.com/user-attachments/assets/ca9b94ef-d723-4085-8942-3435e5603071)
![350775808-01f94621-4a89-4537-b01c-a34100e8abe2](https://github.com/user-attachments/assets/25b14fbd-d0af-4524-99ed-0f72c5e82a0e)
![351025773-ed7d53d8-9a61-44d8-966d-07c08155b3df](https://github.com/user-attachments/assets/3aed1b26-d45f-4f4c-a880-4dd178b6ee9e)
![350775806-50466855-33a8-454a-b5a9-44f49ebc57ac](https://github.com/user-attachments/assets/b43264e6-f5a4-469b-bfd4-938fcc74f536)





If you encounter any issues or have questions, feel free to open an issue in the repository or contact the project maintainers.

Happy Coding!

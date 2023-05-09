# my_pets_app

A new Flutter project, by Team Runtime_error.

## Team Members
- Samuel Espinoza
- Seth Hoskins
- Travis Russell
- Nikki Liu

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Introduction

## Requirements

This tutorial has good instructions on how to install Flutter on Windows, Mac, and Linux. It also has instructions on how to install Android Studio and VS Code.
- [How to install Flutter SDK and Android Studio](https://www.liquidweb.com/kb/how-to-install-and-configure-flutter-sdk-windows-10/)
Make sure to follow the instructions for the Flutter SDK, Android Studio, and VS Code, and to set up the enviroment variable for the Flutter SDK, so you can run the `flutter` command in the terminal.

Step1: Install Flutter
- [Flutter SDK](https://flutter.dev/docs/get-started/install)

Step2: Install Android Studio
- [Android SDK](https://developer.android.com/studio)

       You don't need to create an Android Virtual Device (AVD) for this project, but you will need to install the Android SDK.
        
Step3: Install VS Code
- [VS Code Installation Kit](https://code.visualstudio.com/download)

        Within VS Code, install the following extensions:
        - Dart
        - Flutter
        - bloc
        - Awesome Flutter Snippets
        - Error Lens
        - dart-import
        - DotENV
        - vscode-icons
       
In order to connect the project to the database (Firebase), you will need to install the following:
- [Firebase CLI](https://firebase.google.com/docs/cli)


## Features

## Documentation
- [System Documentation](SystemDocumentation.md )
- [User Guide](UserGuide.md)

Database ERD

![Database entity relationship diagram](documentation/ERD.png?raw=true "Database ERD")


# FIREBASE CRUD OPERATIONS

- ACCESSING THE CURRENT USER ID
`FirebaseAuth.instance.currentUser.uid`


- ACCESSING THE CURRENT USER EMAIL
`FirebaseAuth.instance.currentUser.email`

- ACCESSING COLLECTIONS
`FirebaseFirestore.instance.collection('collectionName')` 

*Note: collectionName is the name of the collection you want to access*
*we already have a global variable in the db_constants.dart file for the users collection*
*you can access a collection within a user document*

- ACCESSING DOCUMENTS
`FirebaseFirestore.instance.collection('collectionName').doc('documentName')`

*Note: documentName is the name of the document you want to access*
*in most cases documentName will be the current users id or uid, you can use the methods described above to access the current user id and assign it to a variable of better use, this document is where we get the users profile information*

- ACCESSING USERS COLLECTIONS
`FirebaseFirestore.instance.collection('users').doc('documentName').collection('collectionName')`

*Note: documentName is the name of the document you want to access*
*in most cases documentName will be the current users id or uid, you can use the methods described above to access the current user id and assign it to a variable of better use*
*collectionName is the name of the collection you want to access, here is where we will access each users, lists of pets and favorite breeds*

- ACCESSING USERS COLLECTIONS DOCUMENTS
`FirebaseFirestore.instance.collection('users').doc('documentName').collection('collectionName').doc('documentName')`

*Note: documentName is the name of the document you want to access*
*in most cases documentName will be the current users id or uid, you can use the methods described above to access the current user id and assign it to a variable of better use*
*collectionName is the name of the collection you want to access, here is where we will access each users, lists of pets and favorite breeds*
*documentName will most likely be the document id created*

- ADDING DATA TO A USERS SUB COLLECTION
`FirebaseFirestore.instance.collection('users').doc('uid').collection('collectionName').doc('documentName').set('object')`

*Note: uid is the name of the document you want to access, in most cases will be the current user id*
*collectionName is the name of the collection you want to access, here is where we will access each users, lists of pets and favorite breeds, example 'favorites', 'pets', etc*
*documentName will most likely be the document id that will be passed in by the object*
*object is the object that will be passed in, this object will be the data that will be added to the collection*

- REMOVING DATA FROM A USERS SUB COLLECTION
`FirebaseFirestore.instance.collection('users').doc('uid').collection('collectionName').doc('documentName').delete()`

*Note: uid is the name of the document you want to access, in most cases will be the current user id*
*collectionName is the name of the collection you want to access, here is where we will access each users, lists of pets and favorite breeds, example 'favorites', 'pets', etc*
*documentName will most likely be the document id that will be passed in by the object*

- CHECKING IF A DOCUMENT EXISTS
 `FirebaseFirestore.instance.collection('users').doc('uid').collection('collectionName').doc('documentName').get()`<---- this returns a boolean value, true if the document exists, false if it does not

- UPDATING A DOCUMENT 
 `FirebaseFirestore.instance.collection('users').doc('uid').collection('collectionName').doc('documentName').update('object')`

*Note: uid is the name of the document you want to access, in most cases will be the current user id*
*collectionName is the name of the collection you want to access, here is where we will access each users, lists of pets and favorite breeds, example 'favorites', 'pets', etc*
*documentName will most likely be the document id that will be passed in by the object*
*object is the object that will be passed in, this object will be the data that will be added to the collection*

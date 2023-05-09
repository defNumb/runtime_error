# System Documentation for my_pets_app

JCCC 2023 Spring Semester
A new Flutter project, by Team Runtime_error

- [Back to README](README.md)

## Team Members
- Samuel Espinoza
- Seth Hoskins
- Travis Russell
- Nikki Liu

#### Introduction
"my_pets_app" is a mobile application developed using the Flutter UI framework with the Dart programming language. The application allows users to sign up and log in, browse through a dog dictionary, browse through a cat dictionary, favorite any breed they like, and access the home page.

#### Requirements Document
##### Functional Requirements
1. User Registration: The user can create a new account by providing their name, email address, and password.
2. User Login: When the user is logged out, the user can log in to their account by entering their email and password.
3. Home Page: Upon logging in, the user is directed to the home page, where they can see the latest dog and cat breeds added to the app. Acts as the root page of the entire app. The Home Page also displays a few widgets featuring sample information on a random pet.
4. Profile Page: The user can see and edit account information like their name email address, and password. The user can also sign out of the application.
5. Dog Dictionary: The user can browse through a dictionary of dog breeds, and view details such as breed name, images of that breed, and characteristics. This is accessible from the home page.
6. Cat Dictionary: The user can browse through a dictionary of cat breeds, and view details such as breed name, images of that breed, and characteristics. This is accessible from the home page.
7. My Pets Page: The user can add their pet that will be tied to their account. They can enter the pet name, species, breed, and lastly pet birth date.
8. Favorites: The user can add any breed (both dogs and cats) to their favorites list, and view their favorite breeds in a separate list accessible from the home page.

##### Non-Functional Requirements
1. Performance: The application should load data and respond to user interactions quickly and efficiently.
2. Security: The application should store user information securely and ensure that user data is not accessible to unauthorized parties.
3. Compatibility: The application should be compatible with Android devices running Android 5.0 (Lollipop) or later.

#### Design Document
##### High-Level Design
- my_pets_app is built using the [Flutter](https://flutter.dev/) UI framework, which enables rapid prototyping and cross-platform development. The application follows a clean, minimalist design, with a focus on usability and ease of use. Google's [Firebase](https://firebase.google.com/) service is utilized for storing user data and user authentication.

##### Detailed Design
- The application consists of several screens, including the login screen, sign-up screen, registration screen, home screen, dog dictionary screen, cat dictionary screen, my pets screen, and favorites screen. Each screen is designed with a consistent layout and color scheme, includes relevant information on the page, and features navigation options to easily move from screen to screen.

##### Component Design
- The application uses several components, including text fields, buttons, images, icons, layered pages, pop-up shelves, and lists. The application utilizes API via [The Dog API](https://thedogapi.com/) and [The Cat API](https://thecatapi.com/) to supply the information and images. The application also uses Firebase authentication and the Firestore database to store user information and pet data.

##### User Guide
- my_pets_app comes with a user guide that provides instructions on how to use the app. The guide includes information on how a user can create a new account, navigate the app, edit account information via the profile page, browse pet breeds, add pets via the my pets page, and favorite pet breeds.
- [User Guide](UserGuide.md)

##### Technical Manual
- my_pets_app is built using the Flutter UI framework and Dart programming language, which enables cross-platform development and rapid prototyping. The Google Firebase database is used to store user data and pet information. "The Dog API" and "The Cat API" are two external APIs used to obtain information on dog and cat breeds. This information is then cached to the phone to avoid repeated API calls and improve app performance. The app uses Firebase Authentication to secure user data and ensure that only authorized users can access it. 
- Data flow: The app is deployed onto a user's Android smartphone. The user logs in/signs up. The user's login information (first name, last name, email address) is sent to Firebase, where it is stored in a user document (a file stored per user). The user can modify their profile data, which undergoes nearly the same process. The user can add a pet to the app which stores inside of their user document through Firebase. The user can browse through both cat breeds and dog breeds. If it is their first time browsing through either respectively, the information is retrieved using the corresponding API and is cached to the device. If it is not their first time browsing, the cached information is retrieved instead of utilizing an API call. During the browsing of pet breeds, the user can favorite any breed by clicking the heart icon on there. When that happens, the pet breed information is sent to and stored in the Firebase document for the user.
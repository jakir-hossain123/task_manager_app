Task Manager App

A complete Flutter Task Manager application developed as part of an
Ostad assignment.

The app allows users to manage their daily tasks through a simple and
user-friendly interface. Users can create, update, delete, and change
the status of tasks, as well as manage their profile info and authentication.

Features

User Registration

User Login

User Authentication

Task Dashboard

Task Status Count

Create New Task

Update Task

Delete Task

Change Task Status

New Task List

Progress Task List

Completed Task List

Cancelled Task List

Profile Update

Forgot Password / OTP Flow

Loading, Success and Error Handling

REST API Integration

Task Status

Tasks can be managed using four different statuses:

New --- Newly created tasks

Progress --- Tasks currently being worked on

Completed --- Finished tasks

Cancelled --- Cancelled tasks

Technologies Used

Flutter

Dart

REST API

HTTP

Provider

Shared Preferences

API Integration

The application integrates REST APIs for:

User Registration

User Login

Task Creation

Task List by Status

Task Status Update

Task Update

Task Deletion

Profile Update

Password Recovery

Screenshots

Splash Screen



Login Screen



Sign Up Screen



New Tasks



Add Task



Task Status Change



Progress Tasks



Completed Tasks



Cancelled Tasks



Task Delete



Profile Update



Password Recovery Note

The password recovery flow has been implemented according to the
provided API collection. The recovery email endpoint currently returns
an HTTP 404 response from the deployed backend.

Project Structure

lib/
├── controller/
├── models/
├── screens/
├── services/
└── ...


The project was tested on an Android device and the main task management
features were verified.
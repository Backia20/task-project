# Smart Storage Locker App – Flutter

## Overview
This Flutter-based mobile application was developed as part of the internship task for **Popkey Private Limited**. The app allows users to register, log in, manage assigned lockers, open lockers remotely, and view access logs.

## Features

### 1. Home Screen
- Buttons for **Login** and **Register**

### 2. Register Screen
- New user registration  
- Stores user details locally (mocked backend)

### 3. Login Screen
- User login using email and password  
- Input validation  
- Loading indicator during authentication

### 4. Dashboard
- Displays list of lockers assigned to the user  
- Shows locker ID, size, and last accessed date

### 5. Open Locker
- Allows user to open a locker  
- Generates real-time access log (date)

### 6. Locker Logs
- Displays dates of locker access logs

### 7. Exit Icon / Profile
- Logout functionality  
- Clears cached user data

## Technical Details
- **Framework:** Flutter (single codebase)  
- **State Management:** Provider   
- **API:** Mock REST API  
- **Platform:** Android (APK provided)

## AI Tools Used
- **ChatGPT:** Assisted with debugging, code structuring, and best practices guidance

## How to Run
```bash
flutter pub get
flutter run

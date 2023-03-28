# FlashChat

FlashChat is a chat application for iOS written in Swift. The project uses Firebase Firestore to store messages and authenticate users.

## Features
- User Registration and Login
- Chat Room creation
- Real-time messaging
- User authentication with Firebase 
- Cloud Firestore integration

## Requirements
- Xcode 12.5
- iOS 14.0+
- Swift 5.4
- Firebase Account

## Installation
1. Clone the repo: `git clone https://github.com/markraitman/FlashChat.git`
2. Open `Flash-Chat-iOS/Flash Chat.xcodeproj` with Xcode
3. Install Firebase pods: `pod install`
4. Create a [Firebase Account](https://firebase.google.com/) and set up a new project
5. Add an iOS App to your Firebase project and follow the instructions to add your `GoogleService-Info.plist` file to the project
6. Enable authentication for your Firebase project and set up email authentication
7. Enable Cloud Firestore for your Firebase project

## Usage
1. Register a new account
2. Create a new chat room or select an existing one
3. Chat in real-time with other users

## Acknowledgements
This project was created as part of [The Complete iOS App Development Bootcamp](https://www.udemy.com/course/ios-13-app-development-bootcamp/) course on Udemy. 

## License
[MIT](https://github.com/markraitman/FlashChat/blob/develop/LICENSE)
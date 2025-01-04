# News Circle

### Flutter Version: 3.27.1

## Architecture

I used Clean Architecture as app architecture. I choose this architecture due to its core implementation of S.O.L.I.D principles and repository pattern. Clean Architecture seperates client view (presentation layer) and business logic (data layer) with an intermidiary (domain layer) to communicate between them. Domain layer exposes high-level functions and abstracts their low-level implementation from client.

## State Management

I used Bloc (Business Logic Component) as State management tool with [flutter_bloc](https://pub.dev/packages/flutter_bloc). Bloc facilitates the separation of presentation and business logic, making your Flutter applications more scalable, testable, and maintainable. It leverages the power of reactive programming using Streams.

## Steps to run the app

Step 1: Ensure that you use Flutter version 3.27.1<br/>
Step 2: Add your [News Api](https://newsapi.org/) key in .env.example<br/>
Step 3: Edit file name (.env.example) to (.env)<br/>
Step 4: Run the app<br/>

## Planned Features

- Add feature to save articles offline
- Add settings/preferences to change theme & font size

## Demo

https://github.com/user-attachments/assets/3c209278-ae37-4527-8dc5-4e414e2497db



# Flutter Baby Product Boilerplate

This is a **modular Flutter boilerplate** for building scalable apps using **Clean Architecture** and **GetX**.

It’s designed as a **base template** that you can reuse for any project, whether it’s an e-commerce app, product catalog, or similar.

---

## 💡 Purpose

- Provide a **ready-to-use structure** for Flutter apps
- Handle common features like:
    - API integration with error handling
    - Pagination and pull-to-refresh
    - Login, token management, and session handling
    - Local caching
    - Theme (light/dark) management
    - Global snackbars for messages
- Allow developers to **focus on features**, not boilerplate

---

## 📂 Project Structure

```text
lib
 ├── core
 │    ├── constants        # App-wide constants (API, storage keys, snackbar settings)
 │    ├── errors           # Exception and Failure classes
 │    ├── network          # ApiClient, interceptors, logging
 │    ├── theme            # Colors and theme settings
 │    └── utils            # Global utilities (snackbar, pagination, device detection)
 │
 ├── data
 │    ├── datasources      # Remote & local data sources
 │    │    ├── remote
 │    │    │    ├── auth_remote_data_source.dart
 │    │    │    └── product_remote_data_source.dart
 │    │    └── local
 │    │         ├── auth_local_data_source.dart
 │    │         └── product_local_data_source.dart
 │    ├── models           # Model classes for API mapping
 │    └── repositories     # Repository implementations
 │
 ├── domain
 │    ├── entities         # Core app entities (User, Product, etc.)
 │    ├── repositories     # Abstract repository contracts
 │    └── usecases         # Business logic (login, fetch products, etc.)
 │
 └── presentation
      ├── bindings         # GetX bindings for controllers
      │    ├── auth_binding.dart
      │    └── product_binding.dart
      ├── controllers      # GetX controllers
      │    ├── auth_controller.dart
      │    ├── product_controller.dart
      │    └── theme_controller.dart
      ├── screens          # UI pages
      │    ├── login_screen.dart
      │    ├── product_screen.dart
      │    └── splash_screen.dart
      └── routes           # App route definitions
           └── app_pages.dart
           
           
🔹 How to Read This

core/ → Shared resources, utilities, theme, API setup

data/ → Actual data sources, models, and repository implementations

domain/ → Business logic, entities, and use case contracts

presentation/ → UI layer, controllers, bindings, and navigation

⚡ Key Features

Clean Architecture: Clear separation between presentation, domain, and data layers

GetX State Management: Reactive UI with controllers and dependency injection

Global API Client: Handles GET, POST, PUT, DELETE with error handling

Pagination & Pull-to-Refresh: Ready-made in ProductController

Login & Session Handling: Token saved in local storage; auto-login on app start

Local Caching: Using SharedPreferences

Theme Management: Light/dark toggle with persistent storage

Global Snackbar: Centralized service for showing messages across the app

⚙️ How to Use

1.Clone the project:

 git clone <repo_url>

2.Install dependencies:

 flutter pub get

3.Update API base URL:

Modify lib/core/constants/app_constants.dart

class AppConstants {
  static const String baseUrl = "https://your-api-url.com/";
}

4.Create models / use cases for your project:

Add entities in domain/entities

Add repository contracts in domain/repositories

Implement repositories in data/repositories

Create use cases in domain/usecases

Use controllers & bindings in screens:

Add bindings in presentation/bindings

Add UI pages in presentation/screens

Use Get.find<Controller>() for reactive UI

6.Run the app:

  flutter run

💻 Reusability

This boilerplate can be reused for any Flutter project:

Replace API endpoints and models

Add additional use cases and controllers

Add more screens and bindings

Keep the core structure for scalable, maintainable code

📌 Notes

All controllers are lazy-loaded via bindings

API errors automatically display snackbars

Theme and session are persisted locally

Pagination, pull-to-refresh, and infinite scroll are included

This is a ready-to-use foundation for any product-based app

✅ Summary

This boilerplate helps you start new Flutter projects quickly, with:

Solid Clean Architecture

Ready state management & API handling

Built-in error handling, theme, and session management

Scalable and production-ready structure
# To-Do App

A comprehensive and scalable task management application built with Flutter. This project is designed with a strong focus on Clean Code principles, implementing the MVVM (Model-View-ViewModel) architecture to ensure maintainability, testability, and future scalability.

---

## Key Features

* **Complete Authentication System:** Secure user registration, login, and password management powered by Firebase Authentication.
* **Task Management (CRUD):** Create, read, update, delete, and toggle task status (Pending/Completed) with real-time synchronization using Cloud Firestore.
* **Image Attachments:** Users can attach images to their tasks (via camera or gallery). Images are securely uploaded and retrieved using Firebase Storage.
* **Dynamic Theming:** * Full support for Light and Dark modes.
  * Customizable primary colors: Users can choose their preferred theme color, which applies instantly across the entire application interface.
* **Full Localization (Bilingual):** Custom-built localization supporting both English and Arabic, featuring automatic Right-To-Left (RTL) and Left-To-Right (LTR) layout switching based on the selected language.
* **Precise Time Management:** Users can set exact deadlines for tasks using integrated date and 12-hour (AM/PM) time pickers.
* **Persistent Preferences:** User settings (language, theme color, dark mode state) are saved locally using `SharedPreferences` to ensure a consistent experience across sessions.

---

## Tech Stack & Libraries

* **Framework:** Flutter / Dart
* **State Management:** Cubit (Bloc Pattern)
* **Backend Services (Firebase):**
  * Firebase Authentication
  * Cloud Firestore (NoSQL Database)
  * Firebase Storage (Cloud File Storage)
* **Local Storage:** `shared_preferences`
* **Utilities:** `image_picker` (for handling camera and gallery access)

---

## Architecture & Folder Structure

The application strictly follows the **MVVM (Model-View-ViewModel)** architectural pattern. The UI (View) is completely separated from the business logic and database operations (Model). The `Cubit` acts as the ViewModel, managing the state and connecting the data to the UI efficiently.

The `lib` directory is structured as follows:

```text
lib/
├── core/
│   └── app_words.dart             # Custom localization dictionary
├── models/
│   └── task_model.dart            # Data models and parsing logic
├── service/
│   └── service.dart               # Firebase database operations
├── cubit/
│   ├── auth/                      # Authentication and user preferences state
│   └── task/                      # Task management state
├── widgets/
│   ├── shared/                    # Reusable UI components (e.g., custom text fields)
│   ├── home/                      # Home screen specific widgets
│   └── tasks/                     # Task cards, dialogs, and bottom sheets
└── screens/
    ├── auth/                      # Login, SignUp, and Change Password screens
    └── main/                      # Home, Profile, and Task Details screens
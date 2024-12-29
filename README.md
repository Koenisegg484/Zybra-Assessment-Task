# **Task Management App**

## **Overview**

This is a Flutter-based **Task Management App** built as part of a developer assessment. The app includes functionalities for managing tasks, storing user preferences, and provides a responsive UI for mobile and tablet devices.

## **Features**

### **1. Task Management**
- Add, edit, delete, and view tasks.
- Mark tasks as "Completed" or "Pending."

### **2. Data Storage**
- **SQLite** for persisting task data.
- **Hive** for storing user preferences like app theme and default sort order.

### **3. State Management**
- Utilizes **Riverpod** for managing app state effectively.

### **4. MVVM Architecture**
- **Model**: Represents data structures like tasks and preferences.
- **ViewModel**: Handles business logic and interacts with the model.
- **View**: Displays data and UI components to the user.

### **5. Responsive Design**
- Adapts seamlessly for mobile and tablet devices.

### **6. Additional Features**
- Light and dark mode support.
- Optional: Task search and filter functionality.

---

## **Folder Structure**

```
lib/
├── app/                # Application-level configurations (theme, navigation, etc.)
├── config/             # Constants and configuration files
├── models/             # Data models (Task, UserPreference, etc.)
├── providers/          # Riverpod providers for state management
├── screens/            # UI screens/pages (Task List, Task Details, Settings, etc.)
├── services/           # Services for database operations and other utilities
├── widgets/            # Reusable UI components (buttons, dialogs, etc.)
└── main.dart           # Entry point of the application
```

### **Key Files and Directories**

- **`main.dart`**: Initializes the app and sets up navigation and themes.
- **`app/`**: Includes theme configurations and global settings.
- **`models/`**: Contains `Task` and `UserPreference` data models.
- **`providers/`**: Manages app state using Riverpod.
- **`screens/`**: Includes all the screens like Task List, Task Details, and Settings.
- **`services/`**: Handles data storage logic using SQLite and Hive.
- **`widgets/`**: Houses reusable UI elements for better modularity.

---

## **How to Run the Project**

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd task_manager
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the App**
    - For mobile devices:
      ```bash
      flutter run
      ```
    - For tablets, use the `--device-id` flag to target a specific device.

4. **Testing**
    - Ensure you have an emulator or physical device connected.
    - Run the following command to execute tests (if available):
      ```bash
      flutter test
      ```

---

## **Screenshots**

### Screenshot 1
<img src="Screenshots/SCRST%20(1).jpg" alt="SCRST (1)" width="300"/>

### Screenshot 2
<img src="Screenshots/SCRST%20(1).png" alt="SCRST (1)" width="300"/>

### Screenshot 3
<img src="Screenshots/SCRST%20(2).jpg" alt="SCRST (2)" width="300"/>

### Screenshot 4
<img src="Screenshots/SCRST%20(2).png" alt="SCRST (2)" width="300"/>

### Screenshot 5
<img src="Screenshots/SCRST%20(3).jpg" alt="SCRST (3)" width="300"/>

### Screenshot 6
<img src="Screenshots/SCRST%20(4).jpg" alt="SCRST (4)" width="300"/>

### Screenshot 7
<img src="Screenshots/SCRST%20(5).jpg" alt="SCRST (5)" width="300"/>

### Screenshot 8
<img src="Screenshots/SCRST%20(6).jpg" alt="SCRST (6)" width="300"/>

### Screenshot 9
<img src="Screenshots/SCRST%20(7).jpg" alt="SCRST (7)" width="300"/>

### Screenshot 10
<img src="Screenshots/SCRST%20(8).jpg" alt="SCRST (8)" width="300"/>


---

## **Technologies Used**

- **Flutter** for cross-platform development.
- **Riverpod** for state management.
- **SQLite** and **Hive** for local data storage.
- **Dart** as the programming language.

---


# time_tracker

## Description

A Flutter application that provides a Kanban board for task management, allowing users to create, edit, and move tasks between different columns ("To Do", "In Progress", "Done"). The app includes a timer function to track time spent on each task, a history of completed tasks, and a comment feature for each task. The Todoist API is used for task management, and local storage is handled using SharedPreferences.


## Demo Video

[Watch the video](https://drive.google.com/file/d/1NVU-9KFMjtku9GjIEsAS_ZdvMW2nd6q5/view)

## Features

1. **Kanban Board**:
   - Users can create, edit, and move tasks between different columns ("To Do", "In Progress", "Done").
   - Tasks are displayed in a draggable grid view.

2. **Timer Function**:
   - Users can start and stop tracking the time spent on each task.
   - Time spent on tasks is recorded and displayed.

3. **History of Completed Tasks**:
   - A history of completed tasks is maintained, including the time spent on each task and the date it was completed.

4. **Comments on Tasks**:
   - Users can add, view and delete comments on each task.

5. **Attractive UI**:
   - Custom styling for widgets like AppBars, TabBars, and Buttons.
   - Use of Google Fonts for a modern look.
   - Gradient backgrounds for enhanced visual appeal.

## Best Practices

  - **DRY, KISS, SOLID Principles**: Ensuring code reusability, simplicity, and adherence to best practices.
  - **MVP Principle**: Focus on core functionalities first, with iterative improvements.
  - **User-Centered Design**: Designed with user needs, goals, and preferences in mind.
  - **Performance Optimization**: Fast loading times, smooth scrolling, and minimal memory and battery usage.


## API Services

- The application utilizes the Todoist API for task management.
- Test Token is used for API authentication.
- If certain functionality is not provided by the API, local solutions using SharedPreferences are implemented.

## Getting Started

### Prerequisites

- Flutter SDK: Ensure you have Flutter installed on your machine. Follow the instructions on the official Flutter website to set it up.

### Installation

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd time_tracker
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the Application**:
   ```bash
   flutter run
   ```
## Usage
### Kanban Board
 - Create Task: Add a new task by tapping the 'Add Task' button.
 - Edit Task: Tap on a task to edit its content and description.
 - Move Task: Drag and drop tasks between columns to update their status.

### Timer Function
 - Start Timer: Tap the 'Start' button on a task to begin tracking time.
 - Stop Timer: Tap the 'Stop' button to stop tracking and save the time spent.

### Completed Tasks History
 - View History: Navigate to the 'Completed Tasks' section to see a list of all completed tasks, along with the time spent and completion date.
 - Comments on Tasks
 - Add Comment: Tap on a task and navigate to the comments section to add a comment.
 - View Comments: View all comments associated with a task in the comments section.
 - Delete Comments: Able to Delete All the Comments

### APK Size
 - Android Build APK Size: 7.1 MB

## Screenshots
<img src="https://github.com/user-attachments/assets/b2f63c6d-cbd4-4e1a-895f-8812c72498e9" width="480">
<img src="https://github.com/user-attachments/assets/3e25baf8-ebe1-45a1-8e93-a5cb09c145ce" width="480">
<img src="https://github.com/user-attachments/assets/b0b70236-c7e2-4b2b-b52d-214e841ccd8c" width="480">
<img src="https://github.com/user-attachments/assets/3bc11c3d-58b5-4d97-90de-6d3b56650a0f" width="480">
<img src="https://github.com/user-attachments/assets/0e9d0790-a626-4152-b62d-8ec45fc7c0ef" width="480">
<img src="https://github.com/user-attachments/assets/532d81fd-6d43-49e6-bdd6-ce845d0bff50" width="480">
<img src="https://github.com/user-attachments/assets/6ed24dbc-4715-4222-b3fe-c0928bc63f69)" width="480">
<img src="https://github.com/user-attachments/assets/fb46722e-160a-4999-a487-f295bee0f3b5" width="480">
<img src="https://github.com/user-attachments/assets/af5e9d6a-426d-4ad9-96d9-25a9a5a0b7e4" width="480">

# Task Management System using Ruby on Rails

Welcome to the Task Management System built with Ruby on Rails! This application provides a set of APIs to manage tasks, their statuses, and other related functionalities such as assignment, progress tracking, and task statistics.

## Features

1. **Create Task**: Create a new task with a title, description, and due date.
2. **Update Task**: Update an existing task including its status. Automatically set completion date if the status changes to "Completed".
3. **Delete Task**: Remove a task from the system.
4. **List All Tasks**: Retrieve a list of all tasks.
5. **Assign Task**: Assign a task to a specific user.
6. **Get User's Assigned Tasks**: Fetch a list of tasks assigned to a specific user.
7. **Set Task Progress**: Update the progress percentage of a task.
8. **Get Overdue Tasks**: Retrieve a list of tasks that are overdue.
9. **Get Tasks by Status**: Filter tasks based on their status.
10. **Get Completed Tasks by Date Range**: Fetch completed tasks within a specified date range.
11. **Get Tasks Statistics**: Obtain statistics on total tasks, completed tasks, and percentage completion.
12. **Priority-based Task Queue**: Implement a priority queue for tasks based on due dates and priority levels (High, Medium, Low).

## Implementation Details

- **Database Design**: Utilizes PostgreSQL to store task and user entities.
- **API Endpoints**: Designed following RESTful principles for ease of use and integration.
- **Error Handling**: Comprehensive error handling and appropriate responses for error scenarios.
- **Data Validations**: Robust validations to maintain data integrity and consistency.
- **Security**: Measures to secure APIs and prevent unauthorized access.

## Getting Started

To start using the Task Management System, follow these steps:

1. Clone the repository to your local machine.
2. Install dependencies using Bundler: `bundle install`.
3. Configure the database settings in `config/database.yml` to match your environment.
4. Run migrations to create necessary database tables: `rails db:migrate`.
5. Start the Rails server: `rails server`.
6. You can now access the API endpoints and manage tasks efficiently within your application.

Made with ❤️️ in ATX
# Personal Expense Tracker App
[Video Walkthrough](main_vid.mp4)
## Objective
Build a personal expense tracker app with a simple frontend (Flutter) and backend (Node.js or any backend stack). The app allows users to:

- **Add expenses** via POST request (amount, category, description, date)
- **Display expense summaries** in daily, weekly, or monthly views (GET requests)
- Visualize expenses using **charts** (bar or pie chart) with Flutter's `fl_chart`
- Store data locally or via API calls (backend provided)
- Bonus: Basic **authentication flow** (email OTP or token-based login) using Firebase or similar

---

## Features
- Modular, clean architecture using **Riverpod** (or Provider/Bloc)
- Backend service runs via **Docker** (simple API with JSON/MongoDB/PostgreSQL)
- Unique feature: **Export report as CSV** (justify design in `UNIQUE_FEATURE.md`)
- Robust error handling with user-friendly error messages
- Swagger UI available for API docs and testing
- 2-minute video walkthrough explaining app & backend design (see `/docs` folder)

---

## Backend Setup

The backend is a minimal REST API service for managing expenses.

### Build and run with Docker

```bash
docker build -t expense-tracker .
docker run -d -p 8000:8000 expense-tracker
```
## API Endpoints
* POST /expenses: Add an expense

```bash
curl -X POST http://localhost:8000/expenses \
  -H "Content-Type: application/json" \
  -d '{
        "amount": 25.50,
        "category": "Groceries",
        "description": "Bought vegetables",
        "date": "2025-07-24"
      }'

```
* Get expense summary by period (daily, weekly, monthly):
```bash
# Daily summary
curl "http://localhost:8000/expenses/summary?period=daily"

# Weekly summary
curl "http://localhost:8000/expenses/summary?period=weekly"

# Monthly summary
curl "http://localhost:8000/expenses/summary?period=monthly"

````

## Frontend Setup (Flutter)
This app uses FVM (Flutter Version Management) to ensure consistent Flutter SDK versions.

## Prerequisites
* Install FVM globally:
```bash
dart pub global activate fvm
```
* Install Flutter version 3.19.6 (recommended for compatibility with fl_chart ):
```bash
fvm install 3.19.6
fvm use 3.19.6 --force

```
## Create & run the app
* Clone the repo (or create the app):
```bash
fvm flutter create expense_tracker_app
cd expense_tracker_app

```
Get dependencies:
```bash
fvm flutter pub get

```
Run the app:
```bash
fvm flutter run

```
How to Use
* Run the backend Docker container.
* Start the Flutter app via FVM.
* Use the app UI to add/view expenses or test API via curl or Swagger.
* Export reports or use the unique feature from the app menu.


```bash

```

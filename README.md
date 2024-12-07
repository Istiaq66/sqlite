# Flutter SQLite Scholars App

## Project Overview

This is a Flutter mobile application demonstrating SQLite database integration for managing and displaying a list of scholars. The project serves as a practical exercise in working with local databases in Flutter.

## Features

- Store scholar information in a local SQLite database
- Fetch and display a list of scholars
- View detailed information for individual scholars
- Simple counter functionality

## Project Structure

```
lib/
│
├── models/
│   └── scholar.dart        # Scholar data model
│
├── services/
│   └── database_service.dart  # SQLite database helper
│
├── screens/   
│   └── scholars_list_page.dart  # Scholars list view
│
└── main.dart # Main screen with counter
```

## Key Technologies

- Flutter
- SQLite
- sqflite package
- Local database management

## Getting Started

### Prerequisites

- Flutter SDK
- Android Studio or VS Code
- Android/iOS development environment

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/scholars-sqlite-app.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Database Schema

The `scholar` table includes the following columns:
- `id`: Integer (Primary Key)
- `famous_name`: Text
- `born_on`: Text
- `died_on`: Text
- `lived_in`: Text
- `nick_name`: Text

## Key Learning Points

- SQLite database integration in Flutter
- Asynchronous data fetching
- State management
- Navigation between screens
- Error handling in database operations

## Potential Improvements

- Add CRUD operations
- Implement search functionality
- Add more detailed scholar information
- Implement data validation
- Add more robust error handling

## Troubleshooting

- Ensure you have the latest Flutter SDK
- Check database connection and permissions
- Verify SQLite package installation

## License

MIT License

## Author

[Your Name]
# Blnk - Flutter development task

Develop a small cross-platform application that collects basic registration data from user.

## Features

- **Scan National ID**: Easily scan national ids front and back using camera.
- **Upload Data**: Upload basic information to a google spreadsheet and the ID images to google drive.
- **Custom Page Indicator**: Custom Animated Page Indicator Widget

## Dependencies

The following packages are used in this project:

- **flutter_native_splash**: ^2.4.1
- **fluttertoast**: ^8.2.8
- **flutter_bloc**: ^8.1.6
- **conditional_builder_null_safety**: ^0.0.6
- **camera**: ^0.11.0+2
- **crop_your_image**: ^1.1.0
- **path_provider**: ^2.1.4
- **path**: ^1.9.0
- **http**: ^1.0.0
- **googleapis**: ^13.2.0
- **googleapis_auth**: ^1.6.0


## Getting Started

### Prerequisites

Ensure you have Flutter 3.2 installed on your machine. You can download it from [flutter.dev](https://flutter.dev/).

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/Mohamed-Mourad/Blnk.git

2. Navigate to the project directory:
   ```sh
   cd {path where you cloned the project}
3. Install the dependencies:
   ```sh
   flutter pub get

4. Run the app:
   ```sh
   flutter run

## Project Structure

Here iss a brief overview of the project structure:  
lib/  
├── blocs/               # Contains BLoC files  
├── data/                # Contains data layer of the app  
├── models/              # Contains data models  
├── repositories/        # Contains repository files  
├── screens/             # Contains UI screens  
├── widgets/             # Contains reusable widgets  
├── methods/             # Contains reusable methods  
├── main.dart            # Entry point of the app

# Project Setup Guide

This guide explains how to clone the project, install Flutter, configure the app, run the Flutter app, and start the Node.js TypeScript Express server using Docker Compose.

---

## 1. Clone the Project

```bash
git clone <repository-url>
cd <project-folder>
```

Replace `<repository-url>` with the URL of the Git repository.

Example project structure:

```text
project-folder/
├── app/        # Flutter application
├── server/     # Node.js TypeScript Express server
└── README.md
```

---

# Flutter App Setup

## 2. Install Flutter

Install Flutter from the official Flutter website:

```text
https://docs.flutter.dev/install
```

After installing Flutter, check that the command works:

```bash
flutter --version
```

If the command is not found, Flutter has not been added to your system `PATH`.

---

## 3. Check Flutter Installation

Run:

```bash
flutter doctor
```

This checks if Flutter is correctly installed and shows if anything is missing.

Common things Flutter may ask you to install are:

- Android Studio
- Android SDK
- Android emulator
- Chrome, for web development
- Visual Studio Code or Android Studio Flutter plugin

Follow the instructions from `flutter doctor` until the required checks pass.

---

## 4. Configure the Flutter App

The Flutter app needs a `config` folder containing a `.env` file.

From inside the Flutter app folder, create the config folder:

```bash
cd app
mkdir config
```

Then create a `.env` file inside the `config` folder:

```bash
touch config/.env
```

Add the following value to `config/.env`:

```env
API_URL="https://fitstrive.nathanielnicholas.com/api/"
```

The `API_URL` value decides which server the Flutter app connects to.

For example, if you want to connect to a local server instead, you can change it to:

```env
API_URL="http://localhost:3000/api/"
```

---

## 5. Install Flutter Dependencies

From inside the Flutter app folder:

```bash
flutter pub get
```

---

## 6. Run the Flutter App

Check available devices:

```bash
flutter devices
```

Run the app:

```bash
flutter run
```

Run on a specific device:

```bash
flutter run -d <device-id>
```

Example for Chrome:

```bash
flutter run -d chrome
```

---

## 7. Build the Flutter App

### Android APK

```bash
flutter build apk
```

The APK will be created in:

```text
build/app/outputs/flutter-apk/
```

### Android App Bundle

```bash
flutter build appbundle
```

### Web

```bash
flutter build web
```

The web build will be created in:

```text
build/web/
```

### Linux Desktop

```bash
flutter build linux
```

### Windows Desktop

```bash
flutter build windows
```

### macOS Desktop

```bash
flutter build macos
```

---

# Server Setup Using Docker Compose

The server is run using Docker Compose. This starts both the PostgreSQL database and the Node.js TypeScript Express server.

You do not need to manually install Node.js, run `npm install`, or build the TypeScript server locally.

---

## 8. Install Docker

Install Docker from:

```text
https://www.docker.com/
```

Check that Docker is installed:

```bash
docker --version
docker compose version
```

---

## 9. Create `docker-compose.yml`

Inside the server folder, create a file named:

```text
docker-compose.yml
```

Add the following content:

```yaml
services:
  db:
    image: postgres:16
    container_name: fitstrive-db
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: fitstrive
      POSTGRES_DB: fitstrive
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  server:
    image: fitstrive/server:latest
    restart: unless-stopped
    ports:
      - "3000:3000"
    environment:
      DB_HOST: db
      DB_NAME: fitstrive
      DB_PASSWORD: fitstrive
      DB_PORT: 5432
      DB_USER: postgres

volumes:
  postgres_data:
```

---

## 10. Start the Server

From inside the folder containing `docker-compose.yml`, run:

```bash
docker compose up -d
```

This starts the database and server in the background.

The server should now be available at:

```text
http://localhost:3000
```

If the server exposes API routes under `/api`, the API should be available at:

```text
http://localhost:3000/api/
```

---

## 11. Stop the Server

To stop the server and database:

```bash
docker compose down
```

To stop the containers and also remove the database volume:

```bash
docker compose down -v
```

Only use `-v` if you want to delete the saved PostgreSQL data.

---

## 12. View Server Logs

To view logs from both containers:

```bash
docker compose logs
```

To follow logs live:

```bash
docker compose logs -f
```

To view only the server logs:

```bash
docker compose logs -f server
```

---

# Common Commands

## Flutter

```bash
cd app
flutter doctor
flutter pub get
flutter devices
flutter run
flutter build apk
flutter build web
```

## Server

```bash
cd server
docker compose up -d
docker compose logs -f
docker compose down
```

---

# Troubleshooting

## Flutter command not found

Flutter is probably not added to your system `PATH`.

Add Flutter's `bin` folder to your `PATH` and restart the terminal.

---

## Missing `.env` file in the Flutter app

Make sure the Flutter app has this file:

```text
app/config/.env
```

The file should contain:

```env
API_URL="https://fitstrive.nathanielnicholas.com/api/"
```

---

## Android device not found

Run:

```bash
flutter devices
```

If no Android device is shown:

- Start an Android emulator
- Connect a physical Android device
- Enable USB debugging on the device
- Run `flutter doctor` and fix any Android SDK issues

---

## Docker command not found

Docker is probably not installed or not running.

Install Docker and make sure the Docker service is started.

---

## Server port already in use

Another process may already be using port `3000`.

Change the port mapping in `docker-compose.yml`:

```yaml
ports:
  - "3001:3000"
```

The server will then be available at:

```text
http://localhost:3001
```

---

## Database port already in use

Another PostgreSQL instance may already be using port `5432`.

Change the database port mapping in `docker-compose.yml`:

```yaml
ports:
  - "5433:5432"
```

The server can still use `DB_HOST: db` and `DB_PORT: 5432`, because it connects to PostgreSQL inside the Docker network.

---

## Rebuild or update the server image

If the server image has changed, pull the latest version and restart:

```bash
docker compose pull
docker compose up -d
```

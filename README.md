# WikiFick

A TikTok-style interface for exploring random Wikipedia articles in multiple languages.

## 🚀 Features

✅ Vertical scrolling feed of random Wikipedia articles
✅ Supports 14 languages, including English, Spanish, French, German, Chinese, Japanese, and more
✅ Article previews with images, titles, and excerpts
✅ Share articles directly or copy links
✅ Language selector
✅ Preloading of images and content for smooth scrolling
✅ Responsive design for mobile and tablet

## 📸 Screenshots

<div align="center">
  <img src="https://github.com/jmongaras/wikifick/blob/master/screen_shot/splash_screen.JPEG" alt="Splash Screen" width="250"/>
  <img src="https://github.com/jmongaras/wikifick/blob/master/screen_shot/home_screen.JPEG" alt="Home Selector" width="250"/>
  <img src="https://github.com/jmongaras/wikifick/blob/master/screen_shot/setting_popup.JPEG" alt="Setting PopUp" width="250"/>
  <img src="https://github.com/jmongaras/wikifick/blob/master/screen_shot/language_popup.JPEG" alt="Language PopUp" width="250"/>
  <img src="https://github.com/jmongaras/wikifick/blob/master/screen_shot/likes_list_screen.JPEG" alt="Like List Screen" width="250"/>
</div>


## 🛠 Tech Stack

- **Jdk** (17)
- **Flutter** (3.27.4)
- **Dart**
- **Bloc** for state management
- **sqfLite** for local storage
- **Dio** for API requests

## 🚀 Development

Follow these steps to set up and run the **WikiFick** Flutter project locally.

### 🔹 Prerequisites

Make sure you have the following installed:

- **Flutter SDK** (3.27.4) → [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (Included with Flutter)
- **Android Studio**(Recommended IDEs)
- **Xcode** (For iOS development on macOS)
- **Android Emulator** or **Physical Device** (For testing)

### 🔹 Clone the Repository

```sh
git clone https://github.com/jmongaras/wikifick
cd wikifick
```



### 🔹 Install Dependencies

```sh
flutter pub get  
dart run flutter_native_splash:create
```

### 🔹 Run the App

**For Android & iOS:**

```sh
flutter run  
```

**For Web:**

```sh
flutter run -d chrome  
```

**For Desktop (Windows, macOS, Linux):**

```sh
flutter run -d windows   # For Windows  
flutter run -d macos     # For macOS  
flutter run -d linux     # For Linux  
```

### 🔹 Debugging & Hot Reload

- **Enable Hot Reload:** Automatically updates the UI without restarting the app
- **Use Flutter DevTools:** Run `flutter pub global activate devtools` and access debugging tools
- **Check Logs:** Use `flutter logs` to view app logs

### 🔹 Build Release APK / iOS App

**For Android:**

```sh
flutter build apk --release  
```

or for app bundles:

```sh
flutter build appbundle  
```

**For iOS:**

```sh
flutter build ios --release  
```

## 💡 Contributing

1. Fork the repository
2. Create a new branch
3. Make your changes and commit them
4. Open a pull request

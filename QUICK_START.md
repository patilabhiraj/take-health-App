# Quick Setup & Testing Guide

## 🚀 Get Started in 5 Minutes

### Step 1: Get Dependencies
```bash
cd d:\Take-Health\take_health
flutter pub get
```

### Step 2: Run the App
```bash
flutter run
```

### Step 3: Test Authentication

#### **For Testing WITHOUT Backend API:**

The app will fail to login/register because it tries to reach the API. To test the UI flow:

1. **Modify `AuthRemoteDataSourceImpl`** temporarily for testing:
   - Open: `lib/data/datasources/auth_remote_datasource.dart`
   - Replace the API call with mock data:

```dart
@override
Future<AuthModel> login(String email, String password) async {
  try {
    // Simulate delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return mock user
    final authModel = AuthModel(
      id: '123',
      email: email,
      name: 'Test User',
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      isAuthenticated: true,
    );

    await prefs.setString(_tokenKey, authModel.token ?? '');
    await prefs.setString(_userKey, jsonEncode(authModel.toJson()));

    return authModel;
  } catch (e) {
    logError('Login error', e);
    rethrow;
  }
}
```

2. **Do the same for `register()` method**

3. **Then run the app** - Login/Register will work with mock data!

#### **For Testing WITH Backend API:**

1. Update API endpoint in `lib/core/constants/app_constants.dart`:
   ```dart
   static const String baseUrl = 'your_backend_url_here';
   ```

2. Ensure backend has `/auth/login` and `/auth/register` endpoints

3. Run the app

---

## 📱 What You Can Test

### ✅ Register Page
- Switch from Login to Register mode
- Fill in: Name, Email, Password
- Click Sign Up
- Should show loading spinner
- Then redirect to HomeScreen

### ✅ Home Page
- Shows user name and email
- Logout button in top right
- Click logout → confirmation dialog
- After logout → redirects to Login

### ✅ Persistent Login
- Login/Register successfully
- Close the app
- Reopen the app
- Should show HomeScreen directly (not LoginScreen)

### ✅ Error Handling
- Try with empty fields → "Please fill all fields" message
- If mock API fails → Shows error message

---

## 📂 Project Structure

```
take_health/
├── lib/
│   ├── core/
│   │   ├── constants/app_constants.dart
│   │   ├── theme/app_theme.dart
│   │   └── utils/
│   │       ├── service_locator.dart ⭐ (All dependencies)
│   │       ├── logger.dart
│   │       └── failure.dart
│   │
│   ├── domain/
│   │   ├── entities/auth_entity.dart ⭐
│   │   ├── repositories/auth_repository.dart ⭐
│   │   └── usecases/
│   │       ├── login_usecase.dart ⭐
│   │       ├── register_usecase.dart ⭐
│   │       ├── logout_usecase.dart ⭐
│   │       └── get_current_user_usecase.dart ⭐
│   │
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── base_remote_datasource.dart
│   │   │   └── auth_remote_datasource.dart ⭐
│   │   ├── models/auth_model.dart ⭐
│   │   └── repositories/auth_repository_impl.dart ⭐
│   │
│   ├── presentation/
│   │   ├── providers/
│   │   │   ├── base_provider.dart
│   │   │   └── auth_provider.dart ⭐
│   │   ├── screens/
│   │   │   ├── login_screen.dart ⭐
│   │   │   └── home_screen.dart ⭐
│   │   └── widgets/common_widgets.dart
│   │
│   └── main.dart ⭐
│
├── pubspec.yaml ✅ (All dependencies added)
├── ARCHITECTURE.md ✅
└── AUTH_IMPLEMENTATION.md ✅
```

⭐ = Auth-related files (NEW)
✅ = Already set up

---

## 🔑 Key Classes

### AuthProvider (State Management)
```dart
final authProvider = Provider.of<AuthProvider>(context);
authProvider.isLoggedIn      // true if logged in
authProvider.user            // Current user (AuthEntity)
authProvider.isLoading       // Loading state
authProvider.error           // Error message
await authProvider.login(email, password)
await authProvider.register(email, password, name)
await authProvider.logout()
```

### AuthEntity (User Data)
```dart
user.id           // User ID
user.email        // User email
user.name         // User name
user.token        // Auth token
user.isAuthenticated  // true if logged in
```

---

## 🛠️ Troubleshooting

### "Failed to build" after changes
```bash
flutter clean
flutter pub get
flutter run
```

### JSON model errors
```bash
flutter pub run build_runner build
```

### API connection timeout
- Check `AppConstants.baseUrl` is correct
- Verify backend is running
- Check network connection

---

## ✨ Next Features to Add

After auth is working, implement:

1. **Health Records** - Log daily health metrics
2. **Doctors** - Manage doctor appointments
3. **Medications** - Track medication schedule
4. **Dashboard** - Display health overview

Follow the same architecture pattern! 🎯

---

**Ready to build? Let's go! 🚀**

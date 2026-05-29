# Take Health - Backend Integration Guide

## ✅ Completed Updates

### 1. API Endpoints Configuration
- **Backend URL**: `https://ai-healthcare-ip88.onrender.com`
- All auth endpoints updated in `lib/core/constants/api_constants.dart`

### 2. Auth Flow Implementation

#### Registration Flow
1. User fills registration form (name, email, password, phone)
2. App calls `POST /auth/register` with `name` field (firstName + lastName combined)
3. Backend sends OTP to email
4. User enters OTP on Email Verification page
5. App calls `POST /auth/register-otp` with email and OTP
6. Backend returns token and user data
7. Token saved locally, user logged in

#### Login Flow
1. User enters email and password
2. App calls `POST /auth/login`
3. Backend returns token and user data directly
4. Token saved locally, user logged in

#### Forgot Password Flow
1. User enters email
2. App calls `POST /auth/forgot-password` (sends reset code to email)
3. User enters reset code (OTP)
4. App calls `POST /auth/verify-reset-code` to verify
5. User enters new password
6. App calls `POST /auth/reset-password`
7. Password reset successful

#### Logout Flow
1. User clicks logout
2. App calls `POST /auth/logout` (backend invalidates token)
3. Local token deleted
4. User redirected to splash screen

### 3. Data Model Updates
- `UserModel.fromJson()` now handles both:
  - Single `name` field (splits into firstName/lastName)
  - Separate `firstName`/`lastName` fields
- Flexible token extraction from various response formats
- Profile image URL parsing from multiple field names

### 4. Token Management
- Token saved after successful login
- Token saved after successful OTP verification
- Token deleted on logout (both backend and local)
- Auto-login on app start if valid token exists

---

## 🧪 Testing Checklist

### Prerequisites
1. Ensure backend is running: `https://ai-healthcare-ip88.onrender.com`
2. Add Take Health logo to `assets/icons/logo.png`
3. Run `flutter pub get` if not already done

### Test Cases

#### ✅ Registration + Email Verification
```
1. Open app → Click "Create Account"
2. Fill form:
   - Full Name: "John Doe"
   - Email: "test@example.com"
   - Phone: "+1234567890"
   - Password: "Test@123"
3. Click "Create Account"
4. Should navigate to Email Verification page
5. Check email for OTP
6. Enter 6-digit OTP
7. Should login and navigate to home
```

**Expected Backend Calls:**
- `POST /auth/register` → Returns OTP sent message
- `POST /auth/register-otp` → Returns token + user data

#### ✅ Login
```
1. Open app → Click "Sign In"
2. Enter email and password
3. Click "Sign In"
4. Should navigate to home
```

**Expected Backend Calls:**
- `POST /auth/login` → Returns token + user data

#### ✅ Forgot Password
```
1. Login page → Click "Forgot Password?"
2. Enter email → Click "Send Code"
3. Check email for reset code
4. Enter 6-digit code → Click "Verify Code"
5. Enter new password → Click "Reset Password"
6. Should show success message
7. Login with new password
```

**Expected Backend Calls:**
- `POST /auth/forgot-password` → Sends reset code
- `POST /auth/verify-reset-code` → Verifies code
- `POST /auth/reset-password` → Updates password

#### ✅ Logout
```
1. Login to app
2. Navigate to profile/settings (when implemented)
3. Click logout
4. Should navigate to splash screen
5. Reopen app → Should show splash (not auto-login)
```

**Expected Backend Calls:**
- `POST /auth/logout` → Invalidates token

#### ✅ Auto-Login (Session Persistence)
```
1. Login to app
2. Close app completely
3. Reopen app
4. Should auto-login and navigate to home
```

**Expected Behavior:**
- Token loaded from secure storage
- JWT decoded to get user info
- Auto-navigate to home

---

## 🐛 Debugging

### Enable Detailed Logging
The app uses `AppLogger` for all network calls and auth operations.

**Check logs for:**
- API request URLs and payloads
- API response data
- Token save/load operations
- Error messages

### Common Issues

#### 1. "Failed to register" Error
- **Check**: Backend response format matches `UserModel.fromJson()`
- **Fix**: Update `UserModel` if backend returns different field names

#### 2. "Failed to verify OTP" Error
- **Check**: OTP is 6 digits and not expired
- **Check**: Email matches the one used in registration
- **Fix**: Implement OTP resend if needed

#### 3. "Failed to login" Error
- **Check**: Email is verified (completed OTP step)
- **Check**: Password is correct
- **Check**: Backend returns token in response

#### 4. Auto-login not working
- **Check**: Token is saved in secure storage
- **Check**: JWT format is valid (3 parts separated by dots)
- **Check**: Token contains required fields (id, email)

#### 5. Logout not working
- **Check**: Backend `/auth/logout` endpoint is accessible
- **Check**: Token is deleted from local storage
- **Note**: App continues even if backend call fails

---

## 📝 Backend Response Format Reference

### Registration Response
```json
{
  "success": true,
  "message": "OTP sent to email"
}
```

### OTP Verification Response
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "_id": "507f1f77bcf86cd799439011",
    "name": "John Doe",
    "email": "test@example.com",
    "phone": "+1234567890"
  }
}
```

### Login Response
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "_id": "507f1f77bcf86cd799439011",
    "name": "John Doe",
    "email": "test@example.com",
    "phone": "+1234567890"
  }
}
```

---

## 🚀 Next Steps

### Immediate
1. **Add logo assets** to `assets/icons/` and `assets/images/`
2. **Test registration flow** with real backend
3. **Test login flow** with real backend
4. **Test forgot password flow**

### Future Features (After Auth is Stable)
1. **Profile Management**
   - View profile (`GET /auth/profile`)
   - Update profile (`PUT /auth/profile`)
   - Upload profile picture (`POST /auth/upload-profile-picture`)

2. **AI Chat Feature**
   - Implement chat UI
   - Integrate with `/api/ai/chat` endpoint

3. **Health Features**
   - Analysis (`/api/analysis`)
   - Reports (`/api/reports`)
   - Diet Plan (`/api/diet-plan`)

4. **Google OAuth**
   - Implement Google Sign-In flow
   - Check if backend has Google OAuth endpoint
   - Update `googleLogin()` method accordingly

---

## 📂 Key Files Modified

### Core Layer
- `lib/core/constants/api_constants.dart` - Backend endpoints

### Data Layer
- `lib/features/auth/data/models/user_model.dart` - Response parsing
- `lib/features/auth/data/datasources/auth_remote_data_source.dart` - API calls
- `lib/features/auth/data/repositories/auth_repository_impl.dart` - Token handling

### Assets
- `assets/icons/README.md` - Logo placeholder
- `assets/images/README.md` - Images placeholder

---

## 💡 Tips

1. **Use Postman/Thunder Client** to test backend endpoints directly first
2. **Check backend logs** if API calls fail
3. **Use Flutter DevTools** to inspect network calls
4. **Test on real device** for secure storage functionality
5. **Clear app data** between tests to simulate fresh install

---

## 🆘 Need Help?

If you encounter issues:
1. Check logs in console
2. Verify backend is accessible
3. Test API endpoints with Postman
4. Check response format matches expected structure
5. Review error messages in app (snackbars)

---

**Status**: ✅ Backend integration complete, ready for testing!

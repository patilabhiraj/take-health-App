# Take Health - Testing Guide

## ✅ Recent Updates

### API Endpoints Fixed
- ✅ All endpoints now use `/api` prefix
- ✅ Base URL: `https://ai-healthcare-ip88.onrender.com`
- ✅ Login: `/api/auth/login`
- ✅ Register: `/api/auth/register`

### Timeout Settings
- ✅ Increased to 30 seconds (backend may be slow on free tier)
- ✅ Connect timeout: 30s
- ✅ Receive timeout: 30s
- ✅ Send timeout: 30s

### Error Handling Improved
- ✅ Better error message extraction from backend
- ✅ Handles multiple response formats
- ✅ Shows timeout errors clearly
- ✅ Shows connection errors clearly

---

## 🧪 Test Scenarios

### 1. Wrong Password Test
**Steps:**
1. Open app → Click "Sign In"
2. Enter correct email
3. Enter **wrong password**
4. Click "Sign In"

**Expected Behavior:**
- Loading indicator shows for max 30 seconds
- Error snackbar appears with backend message (e.g., "Invalid credentials")
- Loading stops
- User stays on login page

**If Loading Never Stops:**
- Check console logs for error
- Backend might not be responding
- Check if backend URL is correct

---

### 2. Correct Login Test
**Steps:**
1. Open app → Click "Sign In"
2. Enter correct email and password
3. Click "Sign In"

**Expected Behavior:**
- Loading indicator shows
- Success! Navigate to Home page
- Home page shows "Welcome to Take Health!"
- Logout button in app bar

---

### 3. Registration Test
**Steps:**
1. Open app → Click "Create Account"
2. Fill all fields:
   - Full Name: "John Doe"
   - Email: "test@example.com"
   - Phone: "+1234567890"
   - Password: "Test@123"
3. Click "Continue"

**Expected Behavior:**
- Loading indicator shows
- Navigate to Email Verification page
- Check email for OTP
- Enter OTP
- Navigate to Home page

---

### 4. Backend Connection Test
**Steps:**
1. Open browser
2. Go to: `https://ai-healthcare-ip88.onrender.com/api/auth/login`
3. Should see error (POST required) but confirms backend is up

**If Backend is Down:**
- Error: "Connection timeout" or "Connection error"
- Wait for backend to wake up (free tier sleeps after inactivity)
- Try again after 1-2 minutes

---

## 🐛 Common Issues & Solutions

### Issue 1: "Loading forever" on Login
**Cause:** Backend not responding or timeout
**Solution:**
- Check console logs for actual error
- Verify backend is awake (visit URL in browser)
- Check internet connection
- Timeout is now 30s, should be enough

### Issue 2: "Route not found" Error
**Cause:** Missing `/api` prefix
**Solution:** ✅ Already fixed! All endpoints now have `/api` prefix

### Issue 3: Wrong Password Shows No Error
**Cause:** Error message not extracted properly
**Solution:** ✅ Already fixed! Better error handling added

### Issue 4: Backend Returns 404
**Cause:** Endpoint path incorrect
**Solution:** ✅ Already fixed! Using `/api/auth/login` format

---

## 📱 Testing Checklist

- [ ] Wrong password shows error message
- [ ] Correct login navigates to home
- [ ] Registration sends OTP
- [ ] OTP verification works
- [ ] Logout works
- [ ] Auto-login on app restart
- [ ] Forgot password flow
- [ ] Error messages are clear
- [ ] Loading indicators work
- [ ] No infinite loading

---

## 🔍 Debug Console Logs

Look for these in console:

### Successful Login:
```
🔐 Login requested for: user@example.com
✅ Login successful: user@example.com
```

### Failed Login:
```
🔐 Login requested for: user@example.com
❌ Login failed: Invalid credentials
```

### Backend Error:
```
DioException [bad response]: 401
Response data: {"message": "Invalid credentials"}
```

### Timeout Error:
```
DioException [connection timeout]
Connection timeout. Please check your internet.
```

---

## 🚀 Next Steps After Testing

1. **If login works:** Test registration flow
2. **If registration works:** Test OTP verification
3. **If OTP works:** Test forgot password
4. **If all auth works:** Start building home features

---

## 💡 Tips

1. **Backend on free tier?** First request may take 30-60 seconds to wake up
2. **Use real email** for OTP testing
3. **Check spam folder** for OTP emails
4. **Clear app data** between tests for fresh state
5. **Use Flutter DevTools** to inspect network calls

---

## 📞 Need Help?

If issues persist:
1. Share console logs
2. Share backend response (from logs)
3. Confirm backend URL is accessible
4. Check if backend API documentation matches our implementation

---

**Status**: ✅ Code is correct, ready for testing!

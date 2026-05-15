# 🔧 Troubleshooting Guide - Faculty Presentation

## Common Issues & Quick Fixes

### ❌ Issue: "Login Failed" or "Network Error"

**Solution 1: Clear Browser Cache**
1. Press `Ctrl + Shift + Delete`
2. Select "Cached images and files"
3. Click "Clear data"
4. Refresh page with `Ctrl + F5`

**Solution 2: Use Incognito Mode**
1. Press `Ctrl + Shift + N` (Chrome) or `Ctrl + Shift + P` (Firefox)
2. Go to http://localhost:3000
3. Try logging in

**Solution 3: Restart Servers**
1. Close both terminal windows
2. Double-click `START_DEMO.bat`
3. Wait 2 minutes

---

### ❌ Issue: Backend Won't Start (Port 9090 Busy)

**Check if port is in use:**
```cmd
netstat -ano | findstr :9090
```

**Kill the process:**
1. Open Task Manager (Ctrl + Shift + Esc)
2. Find "java.exe" processes
3. Right-click → End Task
4. Restart backend

---

### ❌ Issue: Frontend Won't Start (Port 3000 Busy)

**The frontend will ask:**
```
Would you like to run the app on another port instead? (Y/n)
```
**Type: Y** and press Enter

It will start on port 3001 instead.

---

### ❌ Issue: "Cannot find module" Error

**Solution:**
```cmd
cd frontend
npm install
npm start
```

---

### ❌ Issue: Maven Build Fails

**Solution:**
```cmd
cd backend
mvn clean install -DskipTests
mvn spring-boot:run
```

---

### ❌ Issue: Browser Doesn't Open Automatically

**Manual Steps:**
1. Open any browser
2. Go to: http://localhost:3000
3. Bookmark it for quick access

---

### ❌ Issue: "404 Not Found" After Login

**This means proxy isn't working. Solution:**
1. Stop frontend (Ctrl + C in terminal)
2. Verify `frontend/src/setupProxy.js` exists
3. Restart frontend: `npm start`

---

### ❌ Issue: Blank Page or White Screen

**Solution:**
1. Open browser console (F12)
2. Look for errors
3. If you see CORS errors:
   - Restart both servers
   - Clear browser cache
4. If you see "Failed to fetch":
   - Check backend is running
   - Check http://localhost:9090/api/health

---

## 🆘 Emergency Recovery (If Everything Fails)

### Nuclear Option - Complete Restart:

1. **Close Everything:**
   - Close all browser windows
   - Close all terminal windows
   - Open Task Manager
   - End all "java.exe" and "node.exe" processes

2. **Restart:**
   ```cmd
   cd C:\Users\Pragn\Desktop\JFS
   START_DEMO.bat
   ```

3. **Wait 3 minutes** for everything to start

4. **Test in incognito mode** first

---

## ✅ Verification Checklist

Before presentation, verify:

- [ ] Backend terminal shows: "Started LibraryManagementSystemApplication"
- [ ] Frontend terminal shows: "webpack compiled successfully"
- [ ] Browser opens to http://localhost:3000
- [ ] Login page loads correctly
- [ ] Can login as admin@library.com
- [ ] Dashboard shows statistics
- [ ] Can navigate to Books page
- [ ] Can logout
- [ ] Can login as user@library.com

---

## 📞 Last Resort

If nothing works 5 minutes before presentation:

1. **Show the code instead:**
   - Open VS Code
   - Show backend structure
   - Show frontend components
   - Explain architecture

2. **Use screenshots:**
   - Take screenshots now while it's working
   - Save in a folder
   - Show screenshots if live demo fails

3. **Explain the issue:**
   - "Due to environment issues..."
   - "Let me walk you through the code..."
   - Faculty will understand technical difficulties

---

## 💪 You Got This!

Remember: Even if something goes wrong, you built a complete full-stack application. That's impressive! Stay calm and explain what you built.

# Library Management System - Quick Start Guide

## 🚀 How to Run the Application

### Prerequisites
- Java 17 or higher
- Node.js 16 or higher
- Maven (or use included mvnw)

### Step 1: Start Backend (Spring Boot)

Open a terminal and run:

```cmd
cd backend
mvn spring-boot:run
```

**Backend will start on:** http://localhost:9090/api

Wait for the message: `Started LibraryManagementSystemApplication`

### Step 2: Start Frontend (React)

Open a NEW terminal and run:

```cmd
cd frontend
npm start
```

**Frontend will start on:** http://localhost:3000

The browser should open automatically.

---

## 👤 Demo Login Credentials

### Admin Account
- **Email:** admin@library.com
- **Password:** admin123
- **Access:** Full system access, manage books, users, transactions

### User Account
- **Email:** user@library.com
- **Password:** user123
- **Access:** Browse books, borrow books, view fines

---

## 📊 What's Pre-loaded

The system automatically creates:
- ✅ 1 Admin user
- ✅ 1 Regular user
- ✅ 5 Sample books

---

## 🔧 Troubleshooting

### If login fails:
1. Clear browser cache (Ctrl+Shift+Delete)
2. Open browser console (F12) and check for errors
3. Verify backend is running on port 9090
4. Verify frontend is running on port 3000

### If port 9090 is busy:
Edit `backend/src/main/resources/application.properties`:
```properties
server.port=8080
```

Then update `frontend/src/services/apiService.js`:
```javascript
baseURL: 'http://localhost:8080/api'
```

### If port 3000 is busy:
The frontend will automatically ask to use port 3001

---

## 📱 Application URLs

- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:9090/api
- **H2 Database Console:** http://localhost:9090/api/h2-console
  - JDBC URL: `jdbc:h2:mem:library_db`
  - Username: `sa`
  - Password: (leave empty)

---

## 🎯 Features to Test

### As Admin:
1. Login with admin@library.com
2. Navigate to Books Management
3. Add/Edit/Delete books
4. View all users
5. View all transactions
6. Generate reports

### As User:
1. Login with user@library.com
2. Browse available books
3. View borrowed books
4. Check fines (if any)

---

## 🛑 Stop the Application

Press `Ctrl+C` in both terminal windows to stop the servers.

---

## 📝 Notes

- The database is in-memory (H2), so all data resets when you restart the backend
- JWT tokens expire after 24 hours
- CORS is configured to allow requests from localhost:3000

@echo off
echo ========================================
echo   Library Management System
echo   Starting Demo Environment
echo ========================================
echo.

echo Starting Backend Server...
start "Backend Server" cmd /k "cd backend && mvn spring-boot:run"

echo Waiting 10 seconds for backend to initialize...
timeout /t 10 /nobreak

echo Starting Frontend Server...
start "Frontend Server" cmd /k "cd frontend && npm start"

echo.
echo ========================================
echo   Servers are starting!
echo ========================================
echo.
echo Backend:  http://localhost:9090/api
echo Frontend: http://localhost:3000
echo.
echo Login Credentials:
echo   Admin: admin@library.com / admin123
echo   User:  user@library.com / user123
echo.
echo Press any key to exit this window...
pause > nul

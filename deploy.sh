#!/bin/bash

# Library Management System - Quick Deploy Script
echo "🚀 Library Management System - Deployment Script"
echo "=================================================="

# Check if required tools are installed
check_tool() {
    if ! command -v $1 &> /dev/null; then
        echo "❌ $1 is not installed. Please install it first."
        exit 1
    else
        echo "✅ $1 is installed"
    fi
}

echo "Checking required tools..."
check_tool "node"
check_tool "npm"
check_tool "java"

# Get deployment choice
echo ""
echo "Choose deployment option:"
echo "1) Railway + Vercel (Free, Recommended)"
echo "2) Render + Vercel (Free Alternative)"
echo "3) Local Production Build (Testing)"
read -p "Enter your choice (1-3): " choice

case $choice in
    1)
        echo "🚀 Deploying to Railway + Vercel..."
        
        # Check if Railway CLI is installed
        if ! command -v railway &> /dev/null; then
            echo "Installing Railway CLI..."
            npm install -g @railway/cli
        fi
        
        # Check if Vercel CLI is installed
        if ! command -v vercel &> /dev/null; then
            echo "Installing Vercel CLI..."
            npm install -g vercel
        fi
        
        # Deploy backend to Railway
        echo "📦 Deploying backend to Railway..."
        cd backend
        railway login
        railway init
        railway up
        
        echo "⚙️  Please set these environment variables in Railway dashboard:"
        echo "   JWT_SECRET=your-super-secret-jwt-key-here"
        echo "   SPRING_PROFILES_ACTIVE=prod"
        echo "   CORS_ORIGINS=https://your-app.vercel.app"
        
        # Deploy frontend to Vercel
        echo "🌐 Deploying frontend to Vercel..."
        cd ../frontend
        
        # Update API URL (user needs to update this manually)
        echo "⚠️  Please update frontend/.env.production with your Railway backend URL"
        read -p "Press Enter after updating the API URL..."
        
        vercel --prod
        
        echo "✅ Deployment complete!"
        echo "📝 Don't forget to update CORS_ORIGINS in Railway with your Vercel URL"
        ;;
        
    2)
        echo "🚀 Deploying to Render + Vercel..."
        echo "📝 Please follow these steps:"
        echo "1. Go to render.com and create a new Web Service"
        echo "2. Connect your GitHub repository"
        echo "3. Use these settings:"
        echo "   - Build Command: mvn clean package -DskipTests"
        echo "   - Start Command: java -jar target/library-management-system-0.0.1-SNAPSHOT.jar"
        echo "   - Environment: SPRING_PROFILES_ACTIVE=prod"
        echo "4. Set environment variables in Render dashboard"
        echo "5. Deploy frontend to Vercel (same as option 1)"
        ;;
        
    3)
        echo "🏗️  Building for local production..."
        
        # Build backend
        echo "📦 Building backend..."
        cd backend
        ./mvnw clean package -DskipTests
        
        if [ $? -eq 0 ]; then
            echo "✅ Backend build successful"
        else
            echo "❌ Backend build failed"
            exit 1
        fi
        
        # Build frontend
        echo "🌐 Building frontend..."
        cd ../frontend
        npm install
        npm run build
        
        if [ $? -eq 0 ]; then
            echo "✅ Frontend build successful"
        else
            echo "❌ Frontend build failed"
            exit 1
        fi
        
        echo "🎉 Local production build complete!"
        echo "📝 To run locally:"
        echo "   Backend: java -jar backend/target/library-management-system-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod"
        echo "   Frontend: npx serve -s frontend/build -l 3000"
        ;;
        
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "🎉 Deployment process completed!"
echo "📚 Check DEPLOYMENT.md for detailed instructions"
echo "🔗 Demo credentials:"
echo "   Admin: admin@library.com / admin123"
echo "   User: user@library.com / user123"
# 🚀 Library Management System - Deployment Guide

## Quick Deployment (Free Tier)

### Option 1: Railway + Vercel (Recommended)

#### **Step 1: Deploy Backend to Railway**

1. **Create Railway Account**
   - Go to [railway.app](https://railway.app)
   - Sign up with GitHub

2. **Deploy Backend**
   ```bash
   # Install Railway CLI
   npm install -g @railway/cli
   
   # Login to Railway
   railway login
   
   # Navigate to backend folder
   cd backend
   
   # Initialize Railway project
   railway init
   
   # Deploy
   railway up
   ```

3. **Set Environment Variables in Railway Dashboard**
   - `JWT_SECRET`: `your-super-secret-jwt-key-here`
   - `CORS_ORIGINS`: `https://your-app-name.vercel.app`
   - `SPRING_PROFILES_ACTIVE`: `prod`

4. **Get Backend URL**
   - Copy the generated Railway URL (e.g., `https://your-app.railway.app`)

#### **Step 2: Deploy Frontend to Vercel**

1. **Update Frontend Environment**
   ```bash
   # Edit frontend/.env.production
   REACT_APP_API_URL=https://your-railway-app.railway.app/api
   ```

2. **Deploy to Vercel**
   ```bash
   # Install Vercel CLI
   npm install -g vercel
   
   # Navigate to frontend folder
   cd frontend
   
   # Deploy
   vercel --prod
   ```

3. **Update CORS in Railway**
   - Go to Railway dashboard
   - Update `CORS_ORIGINS` with your Vercel URL

---

### Option 2: Render (Alternative Free Option)

#### **Backend: Render Web Service**

1. **Create Render Account**
   - Go to [render.com](https://render.com)
   - Connect your GitHub account

2. **Create Web Service**
   - Click "New +" → "Web Service"
   - Connect your repository
   - Select `backend` folder
   - Configure:
     - **Build Command**: `mvn clean package -DskipTests`
     - **Start Command**: `java -jar target/library-management-system-0.0.1-SNAPSHOT.jar`
     - **Environment**: `SPRING_PROFILES_ACTIVE=prod`

3. **Environment Variables**
   ```
   JWT_SECRET=your-super-secret-jwt-key-here
   CORS_ORIGINS=https://your-app.vercel.app
   PORT=8080
   ```

#### **Frontend: Vercel (Same as above)**

---

### Option 3: Heroku (Paid but Reliable)

#### **Backend: Heroku**

1. **Install Heroku CLI**
   ```bash
   # Install Heroku CLI
   # Windows: Download from heroku.com
   # Mac: brew install heroku/brew/heroku
   # Linux: snap install heroku --classic
   ```

2. **Deploy Backend**
   ```bash
   cd backend
   
   # Login to Heroku
   heroku login
   
   # Create Heroku app
   heroku create your-library-backend
   
   # Set environment variables
   heroku config:set SPRING_PROFILES_ACTIVE=prod
   heroku config:set JWT_SECRET=your-super-secret-jwt-key-here
   heroku config:set CORS_ORIGINS=https://your-app.vercel.app
   
   # Deploy
   git add .
   git commit -m "Deploy to Heroku"
   git push heroku main
   ```

3. **Add Heroku Postgres (Optional)**
   ```bash
   heroku addons:create heroku-postgresql:mini
   ```

---

## Production Deployment (Recommended for Real Use)

### Option 4: AWS/DigitalOcean + CloudFront

#### **Backend: AWS EC2 or DigitalOcean Droplet**

1. **Create Server Instance**
   - AWS EC2 t3.micro or DigitalOcean $6/month droplet
   - Ubuntu 22.04 LTS

2. **Server Setup**
   ```bash
   # Update system
   sudo apt update && sudo apt upgrade -y
   
   # Install Java 17
   sudo apt install openjdk-17-jdk -y
   
   # Install Docker (optional)
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   
   # Install Nginx
   sudo apt install nginx -y
   ```

3. **Deploy Application**
   ```bash
   # Clone repository
   git clone https://github.com/yourusername/library-management-system.git
   cd library-management-system/backend
   
   # Build application
   ./mvnw clean package -DskipTests
   
   # Run application
   nohup java -jar target/library-management-system-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod &
   ```

4. **Configure Nginx**
   ```nginx
   # /etc/nginx/sites-available/library-api
   server {
       listen 80;
       server_name your-domain.com;
       
       location /api {
           proxy_pass http://localhost:8080;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }
   ```

#### **Frontend: AWS S3 + CloudFront or Netlify**

1. **Build for Production**
   ```bash
   cd frontend
   npm run build
   ```

2. **Deploy to S3**
   ```bash
   # Install AWS CLI
   aws configure
   
   # Create S3 bucket
   aws s3 mb s3://your-library-frontend
   
   # Upload build files
   aws s3 sync build/ s3://your-library-frontend --delete
   
   # Configure bucket for static hosting
   aws s3 website s3://your-library-frontend --index-document index.html --error-document index.html
   ```

---

## Database Options

### Development/Testing
- **H2 In-Memory** (current setup) - Good for demos

### Production
- **PostgreSQL** (recommended)
- **MySQL** 
- **AWS RDS**
- **Railway PostgreSQL**
- **Heroku Postgres**

### PostgreSQL Setup Example
```properties
# application-prod.properties
spring.datasource.url=jdbc:postgresql://localhost:5432/library_db
spring.datasource.username=library_user
spring.datasource.password=your_password
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
```

---

## Environment Variables Reference

### Backend
```bash
# Required
JWT_SECRET=your-super-secret-jwt-key-minimum-32-characters
SPRING_PROFILES_ACTIVE=prod
CORS_ORIGINS=https://your-frontend-domain.com

# Optional Database (if using PostgreSQL)
DATABASE_URL=jdbc:postgresql://host:port/database
DB_USERNAME=username
DB_PASSWORD=password

# Optional
PORT=8080
```

### Frontend
```bash
# Required
REACT_APP_API_URL=https://your-backend-domain.com/api

# Optional
GENERATE_SOURCEMAP=false
```

---

## SSL/HTTPS Setup

### Free SSL with Let's Encrypt
```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx -y

# Get SSL certificate
sudo certbot --nginx -d your-domain.com

# Auto-renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

---

## Monitoring & Maintenance

### Health Checks
- Backend: `https://your-backend.com/api/health`
- Frontend: Check if app loads properly

### Logs
```bash
# Backend logs
tail -f nohup.out

# Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Backup Strategy
- Database backups (if using persistent DB)
- Application code in Git
- Environment variables documented

---

## Cost Estimates

### Free Tier (Good for demos/learning)
- **Railway**: Free tier with limitations
- **Vercel**: Free for personal projects
- **Total**: $0/month

### Basic Production (Small scale)
- **Railway Pro**: $5/month
- **Vercel Pro**: $20/month  
- **Total**: $25/month

### Full Production (Scalable)
- **AWS EC2 t3.small**: $17/month
- **AWS RDS db.t3.micro**: $13/month
- **AWS S3 + CloudFront**: $5/month
- **Total**: $35/month

---

## Quick Start Commands

### Deploy to Railway + Vercel (Fastest)
```bash
# Backend
cd backend
npm install -g @railway/cli
railway login
railway init
railway up

# Frontend  
cd ../frontend
npm install -g vercel
vercel --prod
```

### Local Production Test
```bash
# Backend
cd backend
./mvnw clean package -DskipTests
java -jar target/library-management-system-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod

# Frontend
cd frontend
npm run build
npx serve -s build -l 3000
```

---

## Troubleshooting

### Common Issues
1. **CORS Errors**: Update `CORS_ORIGINS` environment variable
2. **Database Connection**: Check DATABASE_URL format
3. **Build Failures**: Ensure Java 17+ and Node 16+
4. **Port Issues**: Check if PORT environment variable is set

### Debug Commands
```bash
# Check Java version
java -version

# Check Node version
node -v

# Test backend health
curl https://your-backend.com/api/health

# Check environment variables
echo $SPRING_PROFILES_ACTIVE
```

Your Library Management System is now ready for deployment! 🚀
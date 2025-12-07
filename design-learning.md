# Design Learning - Project Steps

Complete guide of all steps taken to build and deploy this authentication page project.

---

## 🚀 Project SETUP

### What We Built
- React + Vite + TypeScript project
- Authentication page with shadcn/ui components
- Form validation with Zod and React Hook Form
- Tailwind CSS for styling

### Technologies Used
- React 18
- Vite
- TypeScript
- Tailwind CSS
- shadcn/ui components
- React Hook Form
- Zod

---

## 🔗 Connect to GitHub - 3 Steps

### Step 1: Initialize Git
```bash
git init
```

### Step 2: Create GitHub Repository
1. Go to [github.com](https://github.com)
2. Click **"+"** → **"New repository"**
3. Name it: `Shadcn-authentitcation`
4. Click **"Create repository"**

### Step 3: Connect and Push
```bash
git remote add origin https://github.com/YOUR_USERNAME/Shadcn-authentitcation.git
git branch -M main
git push -u origin main
```

**If you get merge conflicts:**
```bash
git pull origin main --allow-unrelated-histories
git add .
git commit -m "Merge remote changes"
git push -u origin main
```

---

## ☁️ Connect to Vercel - 3 Steps

### Step 1: Create Account
1. Go to [vercel.com](https://vercel.com)
2. Sign in with GitHub

### Step 2: Import Project
1. Click **"Add New..."** → **"Project"**
2. Select your repository: `jllerena1/Shadcn-authentitcation`
3. Vercel auto-detects Vite (no changes needed)

### Step 3: Deploy
1. Verify settings:
   - Framework: **Vite** ✅
   - Build Command: `npm run build` ✅
   - Output Directory: `dist` ✅
2. Click **"Deploy"**
3. Wait for build to finish
4. Your app is live at: `https://your-project.vercel.app`

**Note:** Every push to GitHub automatically deploys to Vercel.

---

## 📊 Add Vercel Analytics

### Installation
```bash
npm i @vercel/analytics
```

### Add to App
Update `src/main.tsx`:
```tsx
import { Analytics } from '@vercel/analytics/react'

// Add <Analytics /> inside ReactDOM.createRoot
<Analytics />
```

### Deploy
```bash
bash update.sh "Add Vercel Analytics"
```

View analytics in Vercel dashboard → Analytics tab.

---

## 🔄 Update Script

### How to Use
```bash
# Automatic mode (asks for message)
bash update.sh

# Quick mode (with message)
bash update.sh "your commit message"
```

### What It Does
1. Detects changes
2. Shows what changed
3. Asks for commit message
4. Does: `add` → `commit` → `push` automatically

---

## 📁 Project Structure

```
src/
├── components/ui/    # shadcn components
├── pages/           # AuthPage.tsx
├── lib/             # utils.ts
├── App.tsx
└── main.tsx
```

---

## ✅ Quick Checklist

### Setup
- [x] React project created
- [x] shadcn/ui installed
- [x] Auth page built

### GitHub
- [x] Git initialized
- [x] Repository created
- [x] Connected and pushed

### Vercel
- [x] Account created
- [x] Project imported
- [x] Deployed successfully

### Analytics
- [x] Installed
- [x] Added to app
- [x] Working

---

## 🎯 Daily Workflow

1. Make code changes
2. Run: `bash update.sh "description"`
3. Vercel auto-deploys
4. Check analytics in Vercel dashboard

---

## 📚 Resources

- **GitHub**: https://github.com/jllerena1/Shadcn-authentitcation
- **Vercel**: https://vercel.com/dashboard
- **shadcn/ui**: https://ui.shadcn.com

---

**Status**: ✅ Complete and Deployed


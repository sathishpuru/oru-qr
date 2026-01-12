# Project Plan

## Project Goal
Build "OruQR", a comprehensive micro SaaS for dynamic QR codes using Nuxt 3, Supabase, Resend, and Stripe.

## Current Sprint
Database Setup & Core QR Code Functionality

## Task List

### ✅ Phase 1: Project Initialization (COMPLETED)
- [x] Initialize Nuxt 3 project
- [x] Configure Environment Variables (.env.sample created)
- [x] Install dependencies (Nuxt, Supabase, Stripe, Resend, QRCode, Tailwind)
- [x] Create initial directory structure
- [x] Set up authentication pages (login, register)
- [x] Create landing page with hero and features
- [x] Build dashboard layout with sidebar navigation
- [x] Configure authentication middleware

### 🔄 Phase 2: Database & Supabase Setup (IN PROGRESS)
- [ ] Create Supabase project (or connect to existing)
- [ ] Run database schema SQL (profiles, qr_codes, scans tables)
- [ ] Set up Row Level Security (RLS) policies
- [ ] Configure Supabase Storage bucket for QR code images
- [ ] Test Supabase connection in the app

### 📋 Phase 3: QR Code Management (NEXT)
- [ ] Create API route: POST /api/qr-codes (create QR code)
- [ ] Create API route: GET /api/qr-codes (list user's QR codes)
- [ ] Create API route: PUT /api/qr-codes/:id (update QR code)
- [ ] Create API route: DELETE /api/qr-codes/:id (delete QR code)
- [ ] Implement QR code generation with qrcode library
- [ ] Build QR code creation page (/dashboard/qr-codes/new)
- [ ] Build QR codes library page (/dashboard/qr-codes)
- [ ] Create QR code detail/edit page

### 📊 Phase 4: Analytics & Tracking
- [ ] Create redirect handler: GET /q/:shortCode
- [ ] Implement scan tracking (device, location, browser)
- [ ] Integrate IP geolocation service
- [ ] Build analytics dashboard
- [ ] Create charts for scan data visualization

### 💳 Phase 5: Stripe Integration
- [ ] Set up Stripe products and prices
- [ ] Create checkout session API route
- [ ] Implement subscription webhook handler
- [ ] Build pricing page
- [ ] Create billing management page
- [ ] Add subscription tier checks and limits

### 📧 Phase 6: Email Integration
- [ ] Set up Resend email templates
- [ ] Implement welcome email
- [ ] Create password reset email
- [ ] Add subscription notification emails
- [ ] Build limit warning emails

## Code Summary (Session 1)

### Files Created:
1. **package.json** - Project dependencies and scripts
2. **nuxt.config.ts** - Nuxt configuration with Supabase and Tailwind modules
3. **tsconfig.json** - TypeScript configuration
4. **.gitignore** - Git ignore rules
5. **assets/css/main.css** - Tailwind CSS with custom theme variables
6. **app.vue** - Main application entry point
7. **pages/index.vue** - Landing page with hero, features, and navigation
8. **pages/login.vue** - Login page with Supabase authentication
9. **pages/register.vue** - Registration page with email verification
10. **pages/dashboard/index.vue** - Dashboard with stats, sidebar, and quick actions
11. **middleware/auth.global.ts** - Authentication middleware for route protection
12. **README.md** - Project documentation and setup instructions

### Dependencies Installed:
- Nuxt 3 (v3.15.1)
- @nuxtjs/supabase (v1.4.0)
- @nuxtjs/tailwindcss (v6.12.2)
- Stripe (v17.5.0) & @stripe/stripe-js (v4.10.0)
- Resend (v4.0.1)
- qrcode (v1.5.4)
- ua-parser-js (v2.0.1)
- TypeScript (v5.7.3)

## Next Immediate Step

**Set up Supabase database:**
1. Create a Supabase project at https://supabase.com
2. Copy the project URL and anon key to `.env` file
3. Run the database schema SQL from SPECS.md in Supabase SQL Editor
4. Configure RLS policies for security
5. Test the connection by running the dev server

## Tech Debt/Bugs
None (New Project)

## Last Updated
2026-01-13 00:43:40 IST

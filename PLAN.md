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

### ✅ Phase 2: Database & Supabase Setup (COMPLETED)
- [x] Create Supabase project (Connected via env vars)
- [x] Run database schema SQL (profiles, qr_codes, scans tables)
- [x] Set up Row Level Security (RLS) policies
- [x] Configure Supabase Storage bucket for QR code images (Created via SQL)
- [x] Test Supabase connection in the app

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

## Code Summary (Session 2)

### Files Created/Modified:
1. **.env** - Configured with Supabase credentials
2. **supabase-schema.sql** - Updated to be idempotent and include RLS and Storage bucket policies
3. **tailwind.config.js** - Created to fix Tailwind CSS configuration
4. **assets/css/main.css** - Fixed undefined class error

### Database Changes:
- Applied schema with tables: `profiles`, `qr_codes`, `scans`, `subscription_usage`
- Configured RLS policies for all tables
- Created `qr-codes` storage bucket and policies

## Next Immediate Step

**Implement QR Code Management:**
1. Create API route: `POST /api/qr-codes` to generate and save QR codes
2. Build the QR code creation page: `/dashboard/qr-codes/new`
3. Integrate `qrcode` library to generate QR images and upload to Supabase Storage

## Tech Debt/Bugs
None

## Last Updated
2026-01-13 22:52:24 UTC

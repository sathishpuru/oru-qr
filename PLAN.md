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
- [x] Create Supabase project (or connect to existing)
- [x] Run database schema SQL (profiles, qr_codes, scans tables)
- [x] Set up Row Level Security (RLS) policies
- [ ] Configure Supabase Storage bucket for QR code images (Manual Step Required in Dashboard)
- [x] Test Supabase connection in the app (Verified Database Connection)

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

### Files Created:
1. **.env** - Created local env file for development (not committed)
2. **scripts/migrate.js** - Temporary migration script (deleted)

### Changes:
- Ran database migration to create schema for `profiles`, `qr_codes`, `scans`, and `subscription_usage`.
- Verified database connectivity and table creation.

## Next Immediate Step

**Configure Supabase Storage & Start QR Code API:**
1. Manually create 'qr-codes' public bucket in Supabase Dashboard.
2. Begin implementing `POST /api/qr-codes` endpoint in `server/api/qr-codes/index.post.ts`.
3. Implement `GET /api/qr-codes` endpoint in `server/api/qr-codes/index.get.ts`.

## Tech Debt/Bugs
- Need to manually configure Supabase Storage bucket as it cannot be done via SQL/API easily without service key.

## Last Updated
2026-01-13 01:00:00 IST

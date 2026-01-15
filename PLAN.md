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
- [x] Create database setup scripts (test connection, apply schema)
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

## Code Summary (Session 2)

### Files Created/Modified:
1. **scripts/test-connection.ts** - Script to verify database connection
2. **scripts/apply-schema.ts** - Script to apply Supabase schema to database
3. **.env** - Environment variables file (created from sample)
4. **.env.sample** - Updated with DATABASE_URL
5. **package.json** - Added dev dependencies for DB scripts

### Dependencies Installed:
- tsx
- pg, @types/pg
- dotenv

## Next Immediate Step

**Finalize Database Setup:**
1. Fill in `.env` with actual Supabase credentials (SUPABASE_URL, SUPABASE_KEY, DATABASE_URL).
2. Run `npx tsx scripts/test-connection.ts` to verify connection.
3. Run `npx tsx scripts/apply-schema.ts` to apply the database schema.
4. Manually create 'qr-codes' bucket in Supabase Storage.

## Tech Debt/Bugs
None (New Project)

## Last Updated
2026-01-15 22:50:00 UTC

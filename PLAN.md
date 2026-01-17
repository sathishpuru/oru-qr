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
- [x] Prepare database schema SQL with idempotent policies and storage bucket creation
- [x] Create database management scripts (apply-schema, test-connection)
- [ ] Create Supabase project (or connect to existing)
- [ ] Run `npx tsx scripts/apply-schema.ts` to set up database
- [ ] Run `npx tsx scripts/test-connection.ts` to verify connection

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
1. **scripts/apply-schema.ts** - Script to apply database schema and storage setup
2. **scripts/test-connection.ts** - Script to verify database connection

### Files Updated:
1. **package.json** - Added dev dependencies (pg, tsx, dotenv)
2. **.env.sample** - Added DATABASE_URL
3. **supabase-schema.sql** - Updated for idempotency and programmatic storage setup

### Dependencies Installed:
- pg (v8.17.1)
- tsx (v4.21.0)
- dotenv (v17.2.3)
- @types/pg (v8.16.0)

## Next Immediate Step

**Execute Database Setup:**
1.  Obtain your Supabase `DATABASE_URL` (Connection String > Node.js)
2.  Add it to your `.env` file along with Supabase URL and Keys.
3.  Run `npx tsx scripts/apply-schema.ts` to provision tables and storage.
4.  Run `npx tsx scripts/test-connection.ts` to verify everything is working.

## Tech Debt/Bugs
None

## Last Updated
2026-01-13 01:00:00 IST

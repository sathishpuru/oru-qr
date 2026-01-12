# OruQR - Dynamic QR Code Management SaaS

A comprehensive micro SaaS application for creating, managing, and tracking dynamic QR codes with powerful analytics.

## 🚀 Features

- **Dynamic QR Codes**: Create QR codes that can be updated without regeneration
- **Analytics Dashboard**: Track scans, locations, devices, and more
- **User Authentication**: Secure login/signup with Supabase
- **Subscription Management**: Stripe integration for billing
- **Custom Designs**: Customize QR code colors and branding
- **Email Notifications**: Powered by Resend

## 🛠️ Tech Stack

- **Framework**: Nuxt 3
- **Database & Auth**: Supabase
- **Payments**: Stripe
- **Email**: Resend
- **Styling**: Tailwind CSS
- **QR Generation**: qrcode library

## 📋 Prerequisites

- Node.js 18+ and npm
- Supabase account
- Stripe account
- Resend account

## 🔧 Setup Instructions

### 1. Clone and Install Dependencies

```bash
npm install
```

### 2. Environment Variables

Copy `.env.sample` to `.env` and fill in your credentials:

```bash
cp .env.sample .env
```

Required environment variables:

```env
# Supabase
SUPABASE_URL=your_supabase_project_url
SUPABASE_KEY=your_supabase_anon_key
SUPABASE_SERVICE_KEY=your_supabase_service_role_key

# Stripe
STRIPE_PUBLISHABLE_KEY=pk_test_xxx
STRIPE_SECRET_KEY=sk_test_xxx
STRIPE_WEBHOOK_SECRET=whsec_xxx

# Resend
RESEND_API_KEY=re_xxx

# App
APP_URL=http://localhost:3000
NODE_ENV=development
```

### 3. Database Setup

Run the SQL scripts in Supabase SQL Editor to create the required tables:

1. Go to your Supabase project dashboard
2. Navigate to SQL Editor
3. Run the schema from `SPECS.md` (Database Schema section)

### 4. Run Development Server

```bash
npm run dev
```

Visit `http://localhost:3000` to see your application.

## 📁 Project Structure

```
oru-qr/
├── assets/
│   └── css/
│       └── main.css          # Tailwind CSS
├── middleware/
│   └── auth.global.ts        # Authentication middleware
├── pages/
│   ├── index.vue             # Landing page
│   ├── login.vue             # Login page
│   ├── register.vue          # Registration page
│   └── dashboard/
│       └── index.vue         # Dashboard
├── server/
│   └── api/                  # API routes (to be added)
├── app.vue                   # Root component
├── nuxt.config.ts            # Nuxt configuration
└── package.json              # Dependencies
```

## 🎯 Next Steps

According to `PLAN.md`, the next tasks are:

1. ✅ Initialize Nuxt 3 project
2. ✅ Configure Environment Variables
3. ✅ Install dependencies
4. ✅ Create initial directory structure
5. ⏳ Set up Supabase database tables
6. ⏳ Create API routes for QR code management
7. ⏳ Implement QR code generation functionality
8. ⏳ Add Stripe integration
9. ⏳ Set up email templates with Resend

## 📝 Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run generate` - Generate static site
- `npm run preview` - Preview production build

## 🔐 Authentication Flow

1. Users register with email/password
2. Email verification sent via Supabase
3. Login redirects to dashboard
4. Protected routes require authentication

## 💳 Subscription Tiers

- **Free**: 3 QR codes, 100 scans/month
- **Pro** ($9/month): 50 QR codes, unlimited scans
- **Enterprise** ($29/month): Unlimited QR codes, API access

## 📚 Documentation

See `SPECS.md` for complete technical specifications and implementation details.

## 🤝 Contributing

This is a private project. For questions, contact the development team.

## 📄 License

Proprietary - All rights reserved

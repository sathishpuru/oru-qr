# Master Prompt: Dynamic QR Code Micro SaaS

## Project Overview
Build a comprehensive micro SaaS application for creating, managing, and tracking dynamic QR codes. Users can generate QR codes that redirect to URLs they can change anytime without regenerating the code, track scan analytics, and manage multiple QR codes from a central dashboard.

## Tech Stack
- **Frontend/Backend**: Nuxt 3 (SSR/SSG with API routes)
- **Database**: Supabase (PostgreSQL + Auth + Storage)
- **Email**: Resend
- **Payment**: Stripe (Subscriptions + Checkout)
- **Hosting**: Vercel/Netlify (recommended)

---

## Core Features

### 1. Authentication & User Management
- Email/password registration and login via Supabase Auth
- OAuth providers (Google, GitHub) optional
- Email verification on signup
- Password reset flow
- User profile management
- Role-based access (free, pro, enterprise tiers)

### 2. QR Code Management
- **Create Dynamic QR Codes**
  - Input destination URL
  - Generate unique short code (e.g., `yourapp.com/q/abc123`)
  - Customize QR code design (colors, logo, patterns)
  - Set QR code name/label
  - Add tags/categories for organization

- **Edit QR Codes**
  - Change destination URL without regenerating QR
  - Update name, tags, and design
  - Enable/disable QR codes
  - Set expiration dates
  - Add UTM parameters automatically

- **QR Code Library**
  - Dashboard view of all QR codes
  - Search and filter (by name, tag, date, status)
  - Bulk actions (delete, export, disable)
  - Sort by scans, date created, etc.

### 3. Analytics & Tracking
- **Scan Tracking**
  - Total scans per QR code
  - Unique vs. repeat scans
  - Scan location (country, city via IP geolocation)
  - Device type (mobile, desktop, tablet)
  - Operating system (iOS, Android, Windows, etc.)
  - Browser information
  - Timestamp of each scan

- **Visual Analytics**
  - Line charts for scans over time
  - Geographic heat maps
  - Device/OS breakdowns (pie charts)
  - Conversion tracking
  - Export analytics as CSV/PDF

### 4. Subscription & Billing
- **Pricing Tiers**
  - **Free**: 3 QR codes, 100 scans/month, basic analytics
  - **Pro** ($9/month): 50 QR codes, unlimited scans, advanced analytics, custom domains
  - **Enterprise** ($29/month): Unlimited QR codes, unlimited scans, white-label, API access

- **Stripe Integration**
  - Checkout session for subscription signup
  - Customer portal for managing subscriptions
  - Webhook handling (subscription created, updated, canceled)
  - Usage-based billing alerts
  - Proration on plan changes
  - Invoice generation and email

### 5. Additional Features
- **Custom Domains**: Pro/Enterprise users can use their own domain
- **QR Code Templates**: Pre-designed templates for common use cases
- **Download Options**: PNG, SVG, PDF formats in multiple sizes
- **Bulk QR Creation**: Upload CSV to create multiple QR codes
- **API Access**: RESTful API for Enterprise users
- **Webhooks**: Notify external services on scan events
- **Team Collaboration**: Share QR codes with team members (Enterprise)

---

## Database Schema (Supabase)

### Users Table (handled by Supabase Auth)
```sql
-- Extended user metadata in profiles table
CREATE TABLE profiles (
  id UUID REFERENCES auth.users PRIMARY KEY,
  email TEXT,
  full_name TEXT,
  avatar_url TEXT,
  subscription_tier TEXT DEFAULT 'free', -- free, pro, enterprise
  stripe_customer_id TEXT,
  stripe_subscription_id TEXT,
  subscription_status TEXT, -- active, canceled, past_due
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### QR Codes Table
```sql
CREATE TABLE qr_codes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  short_code TEXT UNIQUE NOT NULL, -- e.g., 'abc123'
  name TEXT NOT NULL,
  destination_url TEXT NOT NULL,
  description TEXT,
  tags TEXT[], -- array of tags

  -- Design customization
  design_config JSONB DEFAULT '{}', -- colors, logo, pattern

  -- Settings
  is_active BOOLEAN DEFAULT true,
  expires_at TIMESTAMPTZ,

  -- Metadata
  qr_image_url TEXT, -- stored in Supabase Storage
  total_scans INTEGER DEFAULT 0,
  unique_scans INTEGER DEFAULT 0,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_qr_codes_user_id ON qr_codes(user_id);
CREATE INDEX idx_qr_codes_short_code ON qr_codes(short_code);
```

### Scans Table
```sql
CREATE TABLE scans (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  qr_code_id UUID REFERENCES qr_codes(id) ON DELETE CASCADE,

  -- Visitor info
  ip_address TEXT,
  user_agent TEXT,
  device_type TEXT, -- mobile, desktop, tablet
  os TEXT, -- iOS, Android, Windows, etc.
  browser TEXT,

  -- Location
  country TEXT,
  city TEXT,
  latitude FLOAT,
  longitude FLOAT,

  -- Tracking
  referrer TEXT,
  is_unique BOOLEAN DEFAULT true,

  scanned_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_scans_qr_code_id ON scans(qr_code_id);
CREATE INDEX idx_scans_scanned_at ON scans(scanned_at);
```

### Subscriptions Table (optional, or rely on Stripe webhooks)
```sql
CREATE TABLE subscription_usage (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  period_start TIMESTAMPTZ,
  period_end TIMESTAMPTZ,
  qr_codes_created INTEGER DEFAULT 0,
  total_scans INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## API Routes (Nuxt Server Routes)

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user
- `POST /api/auth/forgot-password` - Send reset email
- `POST /api/auth/reset-password` - Reset password

### QR Codes
- `GET /api/qr-codes` - List all user's QR codes (paginated, filtered)
- `POST /api/qr-codes` - Create new QR code
- `GET /api/qr-codes/:id` - Get single QR code details
- `PUT /api/qr-codes/:id` - Update QR code
- `DELETE /api/qr-codes/:id` - Delete QR code
- `POST /api/qr-codes/:id/duplicate` - Duplicate QR code
- `POST /api/qr-codes/bulk` - Bulk create from CSV

### Analytics
- `GET /api/qr-codes/:id/analytics` - Get analytics for specific QR code
- `GET /api/analytics/overview` - Get account-wide analytics
- `GET /api/analytics/export` - Export analytics as CSV

### Redirect (Public)
- `GET /q/:shortCode` - Redirect to destination URL and track scan

### Stripe/Billing
- `POST /api/stripe/create-checkout` - Create Stripe checkout session
- `POST /api/stripe/create-portal` - Create customer portal session
- `POST /api/stripe/webhook` - Handle Stripe webhooks
- `GET /api/billing/usage` - Get current billing period usage

### User/Profile
- `GET /api/user/profile` - Get user profile
- `PUT /api/user/profile` - Update user profile
- `GET /api/user/subscription` - Get subscription details

---

## Frontend Pages (Nuxt Pages)

### Public Pages
- `/` - Landing page (hero, features, pricing)
- `/pricing` - Pricing table with plan comparison
- `/features` - Detailed features showcase
- `/login` - Login page
- `/register` - Registration page
- `/forgot-password` - Password reset request
- `/reset-password` - Password reset form
- `/q/:shortCode` - QR code redirect handler

### Protected Pages (Dashboard)
- `/dashboard` - Overview with stats and recent QR codes
- `/dashboard/qr-codes` - QR codes library (list/grid view)
- `/dashboard/qr-codes/new` - Create new QR code
- `/dashboard/qr-codes/:id` - QR code detail & edit
- `/dashboard/qr-codes/:id/analytics` - Detailed analytics for QR code
- `/dashboard/analytics` - Account-wide analytics
- `/dashboard/settings` - User settings
- `/dashboard/billing` - Subscription & billing management
- `/dashboard/team` - Team management (Enterprise only)

---

## Key Implementation Details

### 1. QR Code Generation
```typescript
// Use qrcode library
import QRCode from 'qrcode'

async function generateQRCode(shortCode: string, design: any) {
  const redirectUrl = `https://yourapp.com/q/${shortCode}`

  const qrOptions = {
    errorCorrectionLevel: 'H',
    type: 'image/png',
    width: 1000,
    color: {
      dark: design.foregroundColor || '#000000',
      light: design.backgroundColor || '#FFFFFF'
    }
  }

  const qrDataUrl = await QRCode.toDataURL(redirectUrl, qrOptions)

  // Upload to Supabase Storage
  const { data, error } = await supabase.storage
    .from('qr-codes')
    .upload(`${shortCode}.png`, qrDataUrl)

  return data.publicUrl
}
```

### 2. Short Code Generation
```typescript
function generateShortCode(length = 8): string {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  let result = ''
  for (let i = 0; i < length; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length))
  }
  return result
}
```

### 3. Scan Tracking with Geolocation
```typescript
// In /q/:shortCode route handler
import { UAParser } from 'ua-parser-js'

export default defineEventHandler(async (event) => {
  const shortCode = event.context.params.shortCode

  // Get QR code from database
  const { data: qrCode } = await supabase
    .from('qr_codes')
    .select('*')
    .eq('short_code', shortCode)
    .single()

  if (!qrCode || !qrCode.is_active) {
    throw createError({ statusCode: 404 })
  }

  // Track scan
  const userAgent = getHeader(event, 'user-agent')
  const ip = getHeader(event, 'x-forwarded-for') || event.node.req.socket.remoteAddress

  const parser = new UAParser(userAgent)
  const device = parser.getDevice()
  const os = parser.getOS()
  const browser = parser.getBrowser()

  // Get geolocation (use service like ipapi.co or maxmind)
  const geoResponse = await fetch(`https://ipapi.co/${ip}/json/`)
  const geoData = await geoResponse.json()

  // Insert scan record
  await supabase.from('scans').insert({
    qr_code_id: qrCode.id,
    ip_address: ip,
    user_agent: userAgent,
    device_type: device.type || 'desktop',
    os: os.name,
    browser: browser.name,
    country: geoData.country_name,
    city: geoData.city,
    latitude: geoData.latitude,
    longitude: geoData.longitude,
    referrer: getHeader(event, 'referer')
  })

  // Update total scans
  await supabase.rpc('increment_qr_scans', { qr_id: qrCode.id })

  // Redirect
  return sendRedirect(event, qrCode.destination_url, 302)
})
```

### 4. Stripe Integration
```typescript
// Create checkout session
import Stripe from 'stripe'
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY)

export default defineEventHandler(async (event) => {
  const { priceId, userId } = await readBody(event)

  const session = await stripe.checkout.sessions.create({
    customer_email: user.email,
    mode: 'subscription',
    payment_method_types: ['card'],
    line_items: [{ price: priceId, quantity: 1 }],
    success_url: `${process.env.APP_URL}/dashboard?success=true`,
    cancel_url: `${process.env.APP_URL}/pricing`,
    metadata: { userId }
  })

  return { sessionId: session.id }
})

// Webhook handler
export default defineEventHandler(async (event) => {
  const sig = getHeader(event, 'stripe-signature')
  const body = await readRawBody(event)

  const stripeEvent = stripe.webhooks.constructEvent(
    body,
    sig,
    process.env.STRIPE_WEBHOOK_SECRET
  )

  switch (stripeEvent.type) {
    case 'customer.subscription.created':
    case 'customer.subscription.updated':
      const subscription = stripeEvent.data.object
      await supabase
        .from('profiles')
        .update({
          stripe_subscription_id: subscription.id,
          subscription_tier: subscription.items.data[0].price.lookup_key,
          subscription_status: subscription.status
        })
        .eq('stripe_customer_id', subscription.customer)
      break

    case 'customer.subscription.deleted':
      await supabase
        .from('profiles')
        .update({
          subscription_tier: 'free',
          subscription_status: 'canceled'
        })
        .eq('stripe_subscription_id', subscription.id)
      break
  }

  return { received: true }
})
```

### 5. Email Templates (Resend)
```typescript
import { Resend } from 'resend'
const resend = new Resend(process.env.RESEND_API_KEY)

// Welcome email
async function sendWelcomeEmail(email: string, name: string) {
  await resend.emails.send({
    from: 'YourApp <noreply@yourapp.com>',
    to: email,
    subject: 'Welcome to YourApp!',
    html: `
      <h1>Welcome ${name}!</h1>
      <p>Thanks for signing up. Start creating your first QR code now.</p>
      <a href="https://yourapp.com/dashboard/qr-codes/new">Create QR Code</a>
    `
  })
}

// Subscription limit warning
async function sendLimitWarningEmail(email: string, tier: string) {
  await resend.emails.send({
    from: 'YourApp <noreply@yourapp.com>',
    to: email,
    subject: 'You\'re approaching your plan limit',
    html: `
      <p>You're close to your ${tier} plan limit. Upgrade to Pro for unlimited scans!</p>
    `
  })
}
```

---

## Middleware & Guards

### Authentication Middleware
```typescript
// middleware/auth.ts
export default defineNuxtRouteMiddleware(async (to) => {
  const user = useSupabaseUser()

  if (!user.value && to.path.startsWith('/dashboard')) {
    return navigateTo('/login')
  }
})
```

### Subscription Check Middleware
```typescript
// middleware/subscription.ts
export default defineNuxtRouteMiddleware(async (to) => {
  const supabase = useSupabaseClient()
  const user = useSupabaseUser()

  if (user.value) {
    const { data: profile } = await supabase
      .from('profiles')
      .select('subscription_tier, subscription_status')
      .eq('id', user.value.id)
      .single()

    // Check limits based on tier
    if (profile.subscription_tier === 'free') {
      const { count } = await supabase
        .from('qr_codes')
        .select('*', { count: 'exact', head: true })
        .eq('user_id', user.value.id)

      if (count >= 3 && to.path === '/dashboard/qr-codes/new') {
        return navigateTo('/pricing')
      }
    }
  }
})
```

---

## Environment Variables

```env
# Supabase
SUPABASE_URL=your_supabase_url
SUPABASE_KEY=your_supabase_anon_key
SUPABASE_SERVICE_KEY=your_service_key

# Stripe
STRIPE_PUBLISHABLE_KEY=pk_test_xxx
STRIPE_SECRET_KEY=sk_test_xxx
STRIPE_WEBHOOK_SECRET=whsec_xxx

# Resend
RESEND_API_KEY=re_xxx

# App
APP_URL=https://yourapp.com
NODE_ENV=production
```

---

## Additional Considerations

### Security
- Rate limiting on scan endpoints
- CORS configuration for API
- Input validation and sanitization
- SQL injection prevention (Supabase handles this)
- XSS protection
- CSRF tokens for forms

### Performance
- Cache QR code images in CDN
- Database indexes on frequently queried fields
- Lazy loading for dashboard components
- Pagination for large datasets
- Background jobs for analytics aggregation

### SEO & Marketing
- Meta tags for landing pages
- Sitemap generation
- Blog for content marketing
- Referral program
- Affiliate system

### Monitoring & Analytics
- Error tracking (Sentry)
- Application performance monitoring
- User behavior analytics (PostHog, Plausible)
- Uptime monitoring

---

This master prompt provides a complete blueprint for building your Dynamic QR Code micro SaaS. Start by setting up the database schema, then implement authentication, followed by core QR functionality, and finally integrate billing. Good luck! 🚀
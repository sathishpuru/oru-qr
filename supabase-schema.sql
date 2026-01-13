-- OruQR Database Schema for Supabase
-- Run this in your Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- PROFILES TABLE
-- ============================================
-- Extended user metadata (extends Supabase auth.users)
CREATE TABLE IF NOT EXISTS profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
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

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Profiles policies
DROP POLICY IF EXISTS "Users can view own profile" ON profiles;
CREATE POLICY "Users can view own profile" 
  ON profiles FOR SELECT 
  USING (auth.uid() = id);

DROP POLICY IF EXISTS "Users can update own profile" ON profiles;
CREATE POLICY "Users can update own profile" 
  ON profiles FOR UPDATE 
  USING (auth.uid() = id);

DROP POLICY IF EXISTS "Users can insert own profile" ON profiles;
CREATE POLICY "Users can insert own profile" 
  ON profiles FOR INSERT 
  WITH CHECK (auth.uid() = id);

-- ============================================
-- QR CODES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS qr_codes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  short_code TEXT UNIQUE NOT NULL,
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

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_qr_codes_user_id ON qr_codes(user_id);
CREATE INDEX IF NOT EXISTS idx_qr_codes_short_code ON qr_codes(short_code);
CREATE INDEX IF NOT EXISTS idx_qr_codes_created_at ON qr_codes(created_at DESC);

-- Enable Row Level Security
ALTER TABLE qr_codes ENABLE ROW LEVEL SECURITY;

-- QR Codes policies
DROP POLICY IF EXISTS "Users can view own QR codes" ON qr_codes;
CREATE POLICY "Users can view own QR codes" 
  ON qr_codes FOR SELECT 
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can insert own QR codes" ON qr_codes;
CREATE POLICY "Users can insert own QR codes" 
  ON qr_codes FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can update own QR codes" ON qr_codes;
CREATE POLICY "Users can update own QR codes" 
  ON qr_codes FOR UPDATE 
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can delete own QR codes" ON qr_codes;
CREATE POLICY "Users can delete own QR codes" 
  ON qr_codes FOR DELETE 
  USING (auth.uid() = user_id);

-- Public read for redirect (anyone can read to redirect)
DROP POLICY IF EXISTS "Anyone can read QR codes for redirect" ON qr_codes;
CREATE POLICY "Anyone can read QR codes for redirect" 
  ON qr_codes FOR SELECT 
  USING (true);

-- ============================================
-- SCANS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS scans (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  qr_code_id UUID REFERENCES qr_codes(id) ON DELETE CASCADE NOT NULL,
  
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

-- Indexes for analytics queries
CREATE INDEX IF NOT EXISTS idx_scans_qr_code_id ON scans(qr_code_id);
CREATE INDEX IF NOT EXISTS idx_scans_scanned_at ON scans(scanned_at DESC);
CREATE INDEX IF NOT EXISTS idx_scans_country ON scans(country);
CREATE INDEX IF NOT EXISTS idx_scans_device_type ON scans(device_type);

-- Enable Row Level Security
ALTER TABLE scans ENABLE ROW LEVEL SECURITY;

-- Scans policies
DROP POLICY IF EXISTS "Users can view scans for their QR codes" ON scans;
CREATE POLICY "Users can view scans for their QR codes" 
  ON scans FOR SELECT 
  USING (
    EXISTS (
      SELECT 1 FROM qr_codes 
      WHERE qr_codes.id = scans.qr_code_id 
      AND qr_codes.user_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "Anyone can insert scans" ON scans;
CREATE POLICY "Anyone can insert scans" 
  ON scans FOR INSERT 
  WITH CHECK (true);

-- ============================================
-- SUBSCRIPTION USAGE TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS subscription_usage (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  period_start TIMESTAMPTZ NOT NULL,
  period_end TIMESTAMPTZ NOT NULL,
  qr_codes_created INTEGER DEFAULT 0,
  total_scans INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for usage queries
CREATE INDEX IF NOT EXISTS idx_subscription_usage_user_id ON subscription_usage(user_id);
CREATE INDEX IF NOT EXISTS idx_subscription_usage_period ON subscription_usage(period_start, period_end);

-- Enable Row Level Security
ALTER TABLE subscription_usage ENABLE ROW LEVEL SECURITY;

-- Subscription usage policies
DROP POLICY IF EXISTS "Users can view own usage" ON subscription_usage;
CREATE POLICY "Users can view own usage" 
  ON subscription_usage FOR SELECT 
  USING (auth.uid() = user_id);

-- ============================================
-- FUNCTIONS
-- ============================================

-- Function to increment QR code scans
CREATE OR REPLACE FUNCTION increment_qr_scans(qr_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE qr_codes 
  SET total_scans = total_scans + 1,
      updated_at = NOW()
  WHERE id = qr_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to handle new user signup (creates profile automatically)
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO profiles (id, email, full_name)
  VALUES (
    NEW.id,
    NEW.email,
    NEW.raw_user_meta_data->>'full_name'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create profile on user signup
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers for updated_at
DROP TRIGGER IF EXISTS update_profiles_updated_at ON profiles;
CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_qr_codes_updated_at ON qr_codes;
CREATE TRIGGER update_qr_codes_updated_at
  BEFORE UPDATE ON qr_codes
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- STORAGE BUCKET (Run in Supabase Dashboard > Storage)
-- ============================================
-- Create a bucket for QR code images
-- You'll need to do this manually in the Supabase Dashboard:
-- 1. Go to Storage
-- 2. Create a new bucket named 'qr-codes'
-- 3. Set it to Public
-- 4. Add policy to allow authenticated users to upload

-- Storage policies (run after creating bucket):
-- INSERT INTO storage.buckets (id, name, public) VALUES ('qr-codes', 'qr-codes', true);

-- Allow authenticated users to upload
-- CREATE POLICY "Authenticated users can upload QR codes"
--   ON storage.objects FOR INSERT
--   WITH CHECK (bucket_id = 'qr-codes' AND auth.role() = 'authenticated');

-- Allow public read access
-- CREATE POLICY "Public can view QR codes"
--   ON storage.objects FOR SELECT
--   USING (bucket_id = 'qr-codes');

-- ============================================
-- SAMPLE DATA (Optional - for testing)
-- ============================================
-- Uncomment to insert sample data after creating a user

-- INSERT INTO qr_codes (user_id, short_code, name, destination_url, description)
-- VALUES (
--   'YOUR_USER_ID_HERE',
--   'abc123',
--   'Sample QR Code',
--   'https://example.com',
--   'This is a sample QR code for testing'
-- );

COMMIT;

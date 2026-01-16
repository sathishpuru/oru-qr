import { Client } from 'pg';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(process.cwd(), '.env') });

const client = new Client({
  connectionString: process.env.DATABASE_URL,
});

async function testConnection() {
  if (!process.env.DATABASE_URL || process.env.DATABASE_URL.includes('your_')) {
    console.error('❌ DATABASE_URL is not defined or is a placeholder in .env');
    console.log('ℹ️  Please update .env with your Supabase connection string.');
    process.exit(1);
  }

  try {
    await client.connect();
    const res = await client.query('SELECT NOW()');
    console.log('✅ Database connection successful:', res.rows[0]);
    await client.end();
  } catch (err) {
    console.error('❌ Database connection failed:', err);
    process.exit(1);
  }
}

testConnection();

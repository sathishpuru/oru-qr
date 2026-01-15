import dotenv from 'dotenv';
import pg from 'pg';

dotenv.config();

const { Pool } = pg;

async function testConnection() {
  const connectionString = process.env.DATABASE_URL;

  if (!connectionString || connectionString.includes('your_supabase_url')) {
    console.error('❌ DATABASE_URL is not set or is still the default value in .env');
    console.log('👉 Please set DATABASE_URL in your .env file to your Supabase connection string.');
    process.exit(1);
  }

  console.log('🔌 Connecting to database...');

  const pool = new Pool({
    connectionString,
  });

  try {
    const client = await pool.connect();
    console.log('✅ Connection successful!');

    const res = await client.query('SELECT NOW() as now, version()');
    console.log(`📅 Server Time: ${res.rows[0].now}`);
    console.log(`🐘 Version: ${res.rows[0].version}`);

    client.release();
    await pool.end();
    process.exit(0);
  } catch (err: any) {
    console.error('❌ Connection failed:', err.message);
    if (err.message.includes('password authentication failed')) {
      console.log('👉 Check your database password in DATABASE_URL.');
    } else if (err.message.includes('does not exist')) {
      console.log('👉 Check your database name.');
    }
    await pool.end();
    process.exit(1);
  }
}

testConnection();
